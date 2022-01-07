//
//  OnboardingCardView.swift
//  HappySnappSwiftUI
//
//  Created by CryptoByNight on 12/10/2020.
//

import SwiftUI

struct OnboardingCardView: View {
    // MARK: - PROPERTIES
    
    var onboarding: Onboarding
    
    @State private var isAnimating: Bool = false
    
    // MARK: - BODY
    
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                // IMAGE
                Spacer()
                // TITLE
                Text(onboarding.title)
                    .foregroundColor(Color("AccentColor"))
                    .font(.title)
                    .fontWeight(.bold)
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 2, x: 2, y: 2)
                    .padding(.horizontal, 20)
                    .multilineTextAlignment(.center)
                
                Spacer()
                
                Image(onboarding.image)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(20)
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 8, x: 6, y: 8)
                    .scaleEffect(isAnimating ? 1.0 : 0.6)
                    .frame(maxWidth: 250)
                
                Spacer()
                
                //FOOTER
                if onboarding.showStartButton {
                    StartButtonView()
                        .padding(.bottom, 40)
                } else {
                    MyImageView(name: "swipeleftmod", contentMode: .scaleAspectFit)
                        .frame(width: 60, height: 60, alignment: .center)
                        .padding(.bottom, 20)
                        .opacity(0.7)
                }
                
                Spacer()
                
            } //: VSTACK
        } //: ZSTACK
        .onAppear() {
            withAnimation(.easeOut(duration: 0.5)) {
                isAnimating = true
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        .background(LinearGradient(gradient: Gradient(colors: onboarding.gradientColors), startPoint: .top, endPoint: .bottom))
        .cornerRadius(20)
        .padding(.horizontal, 20)
    }
}


struct OnboardingCardView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingCardView(onboarding: onboardingData[1])
    }
}
