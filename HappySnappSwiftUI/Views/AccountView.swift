//
//  SettingsView.swift
//  HappySnapp_v2
//
//  Created by CryptoByNight on 04/10/2020.
//

import SwiftUI
import Firebase
import AuthenticationServices
import CryptoKit

struct AccountView: View {
    @ObservedObject var accountViewModel = AccountViewModel()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.window) var window: UIWindow?
    
    @AppStorage("userDataAccept") var userDataAccept = false
    @State var signInHandler: SignInWithAppleCoordinator?
    
    var body: some View {
        VStack {
            
            HStack {
                
                Spacer()
                
                HeaderComponent()
                
                Spacer()
                
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "xmark")
                        .font(.system(size: 20, weight: .bold))
                    
                }
            } //: HSTACK
            .padding()
            
            MyImageView(name: "HS_PDF", contentMode: .scaleAspectFit)
                .frame(width: 150, height: 150)
                .aspectRatio(contentMode: .fit)
            
            Text("ACCOUNT")
                .font(Font.custom("BPchildFatty", size: 25))
                .multilineTextAlignment(.center)
                .foregroundColor(Color("AccentColor"))
                .padding()
            
            Spacer()
            
            Text("You can access your HappySnapps from multiple devices by creating a free account.\n\n If you stay signed in anonymously, your account will only be linked to this device.")
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .padding()
            
            Spacer()
            
            //Form {
            
            //Section {
            
            VStack {
                if accountViewModel.isAnonymous {
                    
                    SignInWithAppleButton()
                        .frame(width: 280, height: 45)
                        .onTapGesture {
                            if userDataAccept == false {
                                userDataAccept = true
                                Analytics.setAnalyticsCollectionEnabled(true)
                            }
                            self.signInWithAppleButtonTapped()
                        }
                    
                } else {
                    Button(action: {
                        self.logout()
                    }) {
                        VStack {
                            HStack {
                                Spacer()
                                Text("SIGN OUT")
                                    .font(Font.custom("BPchildFatty", size: 20))
                                Spacer()
                            }
                            .padding(.vertical, 5)
                        }
                        .background(Capsule().stroke(Color.accentColor, lineWidth: 3))
                        .frame(maxWidth: 250)
                        .padding(.horizontal, 30)
                    }
                }
                
                HStack {
                    Spacer()
                    if accountViewModel.isAnonymous {
                        Text("Signed in anonymously.")
                    }
                    else {
                        VStack {
                            //Text("Thanks for using HappySnapp \(self.accountViewModel.displayName)")
                            Text("Signed in as \(self.accountViewModel.email)")
                        }
                    }
                    Spacer()
                }
            }
            
            
            Divider()
                .padding(.horizontal, 10)
                .padding(.top, 10)
                .padding(.bottom, 10)
            
            
            Text("User data collection will toggle on when signing in with Apple. You can turn off again in settings if desired.")
                .multilineTextAlignment(.center)
                .foregroundColor(Color("AccentColor"))
                .padding()
            
        }
    }
    
    func signInWithAppleButtonTapped() {
        signInHandler = SignInWithAppleCoordinator(window: self.window)
        signInHandler?.link { (user) in
            print("User signed in. UID: \(user.uid), email: \(user.email ?? "(empty)"), Display Name: \(user.displayName ?? "empty")")
            //print("Anonymous? ... \(user.isAnonymous)")
            self.presentationMode.wrappedValue.dismiss()
        }
    }
    
    func logout() {
        self.accountViewModel.logout()
    }
    
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
