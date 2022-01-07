//
//  Onboarding.swift
//  HappySnappSwiftUI
//
//  Created by CryptoByNight on 12/10/2020.
//

import SwiftUI

struct Onboarding: Identifiable {
    
    var id = UUID()
    var title: String
    var image: String
    var gradientColors: [Color]
    var showStartButton: Bool
}

let onboardingData: [Onboarding] = [
    
    Onboarding(title: "Welcome to\nHappySnapp!", image: "640", gradientColors: [Color("background"), Color("onboardingbottom")], showStartButton: false),
    
    Onboarding(title: "Choose what makes you happy", image: "heartstrings", gradientColors: [Color("background"), Color("onboardingbottom")], showStartButton: false),
    
    Onboarding(title: "Press the button to see photos", image: "button", gradientColors: [Color("background"), Color("onboardingbottom")], showStartButton: false),
    
    Onboarding(title: "Swipe right to add and swipe left to skip", image: "choosehappysnapp", gradientColors: [Color("background"), Color("onboardingbottom")], showStartButton: false),
    
    Onboarding(title: "See your 'liked' photos all at once", image: "happysnappscreen", gradientColors: [Color("background"), Color("onboardingbottom")], showStartButton: false),
    
    Onboarding(title: "Share your HappySnapps with friends", image: "artist", gradientColors: [Color("background"), Color("onboardingbottom")], showStartButton: false),
    
    Onboarding(title: "Sign in with Apple or stay anonymous", image: "signingin", gradientColors: [Color("background"), Color("onboardingbottom")], showStartButton: true)
    
]
