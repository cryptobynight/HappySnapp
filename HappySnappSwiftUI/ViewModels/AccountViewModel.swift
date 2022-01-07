//
//  AccountViewModel.swift
//  HappySnapp_v2
//
//  Created by CryptoByNight on 04/10/2020.
//

import Foundation
import Combine
import Resolver
import Firebase

class AccountViewModel: ObservableObject {
    @Published var user: User?
    @Published var isAnonymous = true
    @Published var email: String = ""
    @Published var displayName: String = ""
    
    @Published private var authenticationService: AuthenticationService = Resolver.resolve()
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        authenticationService.$user.compactMap { user in
            user?.isAnonymous
        }
        .assign(to: \.isAnonymous, on: self)
        .store(in: &cancellables)
        
        authenticationService.$user.compactMap { user in
            user?.email
        }
        .assign(to: \.email, on: self)
        .store(in: &cancellables)
        
        authenticationService.$user.compactMap { user in
            user?.displayName
        }
        .assign(to: \.displayName, on: self)
        .store(in: &cancellables)
        
    }
    
    func logout() {
        self.authenticationService.signOut()
    }
    
}
