//
//  FavouritesRepository.swift
//  HappySnapp_v2
//
//  Created by CryptoByNight on 05/10/2020.
//

import Foundation
import Disk

import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseFunctions

import Combine
import Resolver

class BaseFavouritesRepository {
    @Published var favourites = [Picture]()
}

protocol FavouritesRepository: BaseFavouritesRepository {
    func addFav(_ fav: Picture)
    func removeFav(_ fav: Picture)
    func updateFav(_ fav: Picture)
}

class TestDataFavouritesRepository: BaseFavouritesRepository, FavouritesRepository, ObservableObject {
    override init() {
        super.init()
        self.favourites = testDataPictures
    }
    
    func addFav(_ fav: Picture) {
        favourites.append(fav)
    }
    
    func removeFav(_ fav: Picture) {
        if let index = favourites.firstIndex(where: { $0.id == fav.id }) {
            favourites.remove(at: index)
        }
    }
    
    func updateFav(_ fav: Picture) {
        if let index = self.favourites.firstIndex(where: { $0.id == fav.id } ) {
            self.favourites[index] = fav
        }
    }
}

class LocalFavouritesRepository: BaseFavouritesRepository, FavouritesRepository, ObservableObject {
    override init() {
        super.init()
        loadData()
    }
    
    func addFav(_ fav: Picture) {
        self.favourites.append(fav)
        saveData()
    }
    
    func removeFav(_ fav: Picture) {
        if let index = favourites.firstIndex(where: { $0.id == fav.id }) {
            favourites.remove(at: index)
            saveData()
        }
    }
    
    func updateFav(_ fav: Picture) {
        if let index = self.favourites.firstIndex(where: { $0.id == fav.id } ) {
            self.favourites[index] = fav
            saveData()
        }
    }
    
    private func loadData() {
        if let retrievedFavourites = try? Disk.retrieve("favourites.json", from: .documents, as: [Picture].self) {
            self.favourites = retrievedFavourites
        }
    }
    
    private func saveData() {
        do {
            try Disk.save(self.favourites, to: .documents, as: "favourites.json")
        }
        catch let error as NSError {
            fatalError("""
        Domain: \(error.domain)
        Code: \(error.code)
        Description: \(error.localizedDescription)
        Failure Reason: \(error.localizedFailureReason ?? "")
        Suggestions: \(error.localizedRecoverySuggestion ?? "")
        """)
        }
    }
}

class FirestoreFavouritesRepository: BaseFavouritesRepository, FavouritesRepository, ObservableObject {
    @Injected var db: Firestore
    @Injected var authenticationService: AuthenticationService
    @LazyInjected var functions: Functions
    
    var favouritesPath: String = "favourites"
    var userId: String = "unknown"
    
    private var listenerRegistration: ListenerRegistration?
    private var cancellables = Set<AnyCancellable>()
    
    override init() {
        super.init()
        
        authenticationService.$user
            .compactMap { user in
                user?.uid
            }
            .assign(to: \.userId, on: self)
            .store(in: &cancellables)
        
        // (re)load data if user changes
        authenticationService.$user
            .receive(on: DispatchQueue.main)
            .sink { [weak self] user in
                self?.loadData()
            }
            .store(in: &cancellables)
    }
    
    private func loadData() {
        if listenerRegistration != nil {
            listenerRegistration?.remove()
        }
        listenerRegistration = db.collection(favouritesPath)
            .whereField("userId", isEqualTo: self.userId)
            .order(by: "timeStamp", descending: true)
            .addSnapshotListener { (querySnapshot, error) in
                if let querySnapshot = querySnapshot {
                    self.favourites = querySnapshot.documents.compactMap { document -> Picture? in
                        try? document.data(as: Picture.self)
                    }
                }
            }
    }
    
    func addFav(_ fav: Picture) {
        do {
            var addedFav = fav
            addedFav.userId = self.userId
            addedFav.id = "\(addedFav.id)\(self.userId)"
            addedFav.timeStamp = Date().timeIntervalSince1970
            let _ = try db.collection(favouritesPath).document(String(addedFav.id)).setData(from: addedFav)
        }
        catch {
            fatalError("Unable to add favourite: \(error.localizedDescription).")
        }
    }
    
    func removeFav(_ fav: Picture) {
        let favID = fav.id
        db.collection(favouritesPath).document(String(favID)).delete { (error) in
            if let error = error {
                print("Unable to remove favourite: \(error.localizedDescription)")
            }
        }
    }
    
    func updateFav(_ fav: Picture) {
        let favID = fav.id
        do {
            try db.collection(favouritesPath).document(String(favID)).setData(from: fav)
        }
        catch {
            fatalError("Unable to encode favourite: \(error.localizedDescription).")
        }
    }
    
    func migrateFavs(fromUserId: String) {
        let data = ["previousUserId": fromUserId]
        functions.httpsCallable("migrateFavs").call(data) { (result, error) in
            if let error = error as NSError? {
                print("Error: \(error.localizedDescription)")
            }
            print("Function result: \(result?.data ?? "(empty)")")
        }
    }
}

