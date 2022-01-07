//
//  FavouritesCellViewModel.swift
//  HappySnapp_v2
//
//  Created by CryptoByNight on 05/10/2020.
//

import Foundation
import Combine
import Resolver

class FavouritesCellViewModel: ObservableObject, Identifiable  {
    @Injected var favouritesRepository: FavouritesRepository
    
    @Published var favourite: Picture
    
    var id: String = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    init(fav: Picture) {
        self.favourite = fav
        
        $favourite
            .compactMap { $0.id }
            .assign(to: \.id, on: self)
            .store(in: &cancellables)
        
        $favourite
            .dropFirst()
            //.debounce(for: 0.8, scheduler: RunLoop.main)
            .sink { [weak self] fav in
                self?.favouritesRepository.updateFav(fav)
            }
            .store(in: &cancellables)
    }
    
}

