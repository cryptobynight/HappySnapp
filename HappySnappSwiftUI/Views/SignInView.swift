//
//  SignInView.swift
//  HappySnapp_v2
//
//  Created by CryptoByNight on 04/10/2020.
//

import SwiftUI
import Firebase
import AuthenticationServices
import CryptoKit

struct SignInView: View {
    @Environment(\.window) var window: UIWindow?
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var signInHandler: SignInWithAppleCoordinator?
    
    var body: some View {
        VStack {
            
            Group {
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
                
                Image("happySVG")
                    .resizable()
                    .frame(width: 150, height: 150, alignment: .center)
                    .shadow(radius: 20)
                
            }
            
            Spacer()
            
            SignInWithAppleButton()
                .frame(width: 280, height: 45)
                .onTapGesture {
                    self.signInWithAppleButtonTapped()
                }
            
            Spacer()
            
            
            // other buttons will go here
            
            Divider()
                .padding(.horizontal, 15.0)
                .padding(.top, 20.0)
                .padding(.bottom, 15.0)
            
            
            Text("By using HappySnapp you agree to the Terms & Conditions and Privacy Policy")
                .multilineTextAlignment(.center)
                .foregroundColor(Color("AccentColor"))
                .padding()
        } //: VSTACK
    }
    
    func signInWithAppleButtonTapped() {
        signInHandler = SignInWithAppleCoordinator(window: self.window)
        signInHandler?.link { (user) in
            print("User signed in. UID: \(user.uid), email: \(user.email ?? "(empty)"), Display Name: \(user.displayName ?? "empty")")
            print("Anonymous? ... \(user.isAnonymous)")
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}

