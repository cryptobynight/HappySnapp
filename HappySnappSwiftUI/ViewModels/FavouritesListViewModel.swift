//
//  FavouritesListViewModel.swift
//  HappySnapp_v2
//
//  Created by CryptoByNight on 05/10/2020.
//

import Foundation
import Combine
import Resolver

class FavouritesListViewModel: ObservableObject {
    @Published var favouritesRepository: FavouritesRepository = Resolver.resolve()
    @Published var favouritesCellViewModels = [FavouritesCellViewModel]()
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        favouritesRepository.$favourites.map { favs in
            favs.map { fav in
                FavouritesCellViewModel(fav: fav)
            }
        }
        .assign(to: \.favouritesCellViewModels, on: self)
        .store(in: &cancellables)
    }
    
    func removeFavs(fav: Picture) {
        // remove from repo
        favouritesRepository.removeFav(fav)
        
    }
    
    func addFav(fav: Picture) {
        favouritesRepository.addFav(fav)
    }
    
}

