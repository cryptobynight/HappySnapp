//
//  AppDelegate.swift
//  HappySnapp_v2
//
//  Created by CryptoByNight on 04/10/2020.
//

import UIKit
import Firebase
import Resolver
import FirebaseFunctions
import GoogleMobileAds


class AppDelegate: UIResponder, UIApplicationDelegate {
    
    @LazyInjected var authenticationService: AuthenticationService
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FirebaseApp.configure()
        
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        
        return true
    }
    
    
}

