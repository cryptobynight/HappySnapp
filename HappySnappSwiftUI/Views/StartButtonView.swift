//
//  StartButtonView.swift
//  Fructus
//
//  Created by CryptoByNight on 04/09/2020.
//

import SwiftUI
import Firebase

struct StartButtonView: View {
    // MARK: - PROPERTIES
    
    @AppStorage("isOnboarding") var isOnboarding: Bool?
    @AppStorage("userDataAccept") var userDataAccept = false
    @State var showAlert = false
    // MARK: - BODY
    
    var body: some View {
        HStack {
            
            Button(action: {
                isOnboarding = false
                showAlert = true
            }) {
                HStack(spacing: 8) {
                    Text("Get Started")
                    
                    Image(systemName: "arrow.right.circle")
                        .imageScale(.large)
                } //: HSTACK
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(Capsule().strokeBorder(Color("AccentColor"), lineWidth: 1.25))
                
            } //: BUTTON
            .accentColor(Color("AccentColor"))
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("User Data Collection"), message: Text("\nThis Application collects some Personal Data from its Users.\n\n\(privacyPolicy)"),
                  primaryButton: .destructive (Text("Decline")) {
                    userDataAccept = false
                    Analytics.setAnalyticsCollectionEnabled(false)
                  },
                  secondaryButton: .default (Text("Accept")) {
                    userDataAccept = true
                    Analytics.setAnalyticsCollectionEnabled(true)
                  }
            )
        }
    }
}

// MARK: - PREVIEW

struct StartButtonView_Previews: PreviewProvider {
    static var previews: some View {
        StartButtonView()
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
    }
}
