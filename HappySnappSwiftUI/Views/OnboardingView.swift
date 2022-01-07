//
//  OnboardingView.swift
//  HappySnapp_v2
//
//  Created by CryptoByNight on 06/10/2020.
//

import SwiftUI



struct OnboardingView: View {
    
    // MARK: - PROPERTIES
    
    var onboarding: [Onboarding] = onboardingData
    
    // MARK: - BODY
    
    var body: some View {
        TabView {
            ForEach(onboarding[0...6]) { item in
                OnboardingCardView(onboarding: item)
            } //: LOOP
        } //: TAB
        .tabViewStyle(PageTabViewStyle())
        .padding(.vertical, 20)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
