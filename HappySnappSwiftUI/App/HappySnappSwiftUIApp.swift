//
//  HappySnappSwiftUIApp.swift
//  HappySnappSwiftUI
//
//  Created by CryptoByNight on 06/10/2020.
//

import SwiftUI

@main
struct HappySnappSwiftUIApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @AppStorage("isOnboarding") var isOnboarding: Bool = true
    
    var body: some Scene {
        WindowGroup {
            if isOnboarding {
                OnboardingView()
            } else {
                MasterView()
            }
        }
    }
}
