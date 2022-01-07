//
//  NetworkManager.swift
//  HappySnapp_v2
//
//  Created by CryptoByNight on 05/10/2020.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

class NetworkManager: ObservableObject {
    
    @Published var imageList = [Picture]()
    let db = Firestore.firestore()
    
    func fetchData(category: String) {
        
        self.imageList = []
        
        for _ in 0..<10 {
            
            let randomNum = Int.random(in: 1...2000)
            
            let docRef = db.collection(category).document("\(randomNum)_\(category)")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                
                docRef.getDocument { (document, error) in
                    let result = Result {
                        try document?.data(as: Picture.self)
                    }
                    switch result {
                    case .success(let pic):
                        if var pic = pic {
                            //print("Picture: \(pic)")
                            pic.fetchArrayNum = self.imageList.count
                            //print(pic.fetchArrayNum)
                            self.imageList.append(pic)
                            
                        } else {
                            print("Document does not exist")
                        }
                    case .failure(let error):
                        print("Error decoding picture: \(error)")
                    }
                }
                
            }
            
            
        }
        
    }
}






