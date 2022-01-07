//
//  SettingsView.swift
//  HappySnapp_v2
//
//  Created by CryptoByNight on 06/10/2020.
//

import SwiftUI
import Firebase

struct SettingsView: View {
    
    @ObservedObject var settingsViewModel = AccountViewModel()
    @Environment(\.presentationMode) var presentationMode
    @AppStorage("isOnboarding") var isOnboarding: Bool = false
    @AppStorage("userDataAccept") var userDataAccept = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    
                    HStack {
                        
                        Spacer()
                        
                        HeaderComponent()
                            .padding()
                        
                        Spacer()

                    } //: HSTACK
                    
                    // MARK: - SECTION 1
                    GroupBox(label: SettingsLabelView(labelText: "About", labelImage: "smiley")
                    ) {
                        Divider().padding(.vertical, 4)
                        
                        HStack(alignment: .center, spacing: 20) {
                            MyImageView(name: "HS_PDF", contentMode: .scaleAspectFit)
                                .scaledToFit()
                                .frame(width: 90, height: 90)
                                .cornerRadius(9)
                            
                            Text("HappySnapp was made for one simple reason...to put a smile on your face.\n\nI hope it works.")
                                .font(.footnote)
                            
                            Spacer()
                        }
                    }
                    
                    GroupBox(label: SettingsLabelView(labelText: "Photos", labelImage: "photo.on.rectangle")
                    ) {
                        Divider().padding(.vertical, 4)
                        
                        HStack(alignment: .center, spacing: 40) {
                            Image("pexelslogo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 70, height: 60)
                                .cornerRadius(9)
                            
                            Text("Photos provided by Pexels.")
                                .font(.footnote)
                            
                            Spacer()
                        }
                    }
                    
                    // MARK: - SECTION 2
                    GroupBox(
                        label: SettingsLabelView(labelText: "Onboarding", labelImage: "book")
                    ) {
                        Divider().padding(.vertical, 4)
                        
                        Text("You can restart the application and restart the onboarding process by toggling this switch and then sliding the view down and away.")
                            .padding(.vertical, 8)
                            .frame(minHeight: 60)
                            .layoutPriority(1)
                            .font(.footnote)
                            .multilineTextAlignment(.leading)
                        
                        Toggle(isOn: $isOnboarding) {
                            if isOnboarding {
                                Text("Restarted".uppercased())
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("AccentColor"))
                            } else {
                                Text("Restart".uppercased())
                                    .fontWeight(.bold)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding()
                        .background(
                            Color(UIColor.tertiarySystemBackground)
                                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                        )
                        .toggleStyle(SwitchToggleStyle(tint: Color("AccentColor")))
                    }
                    
                    GroupBox(
                        label: SettingsLabelView(labelText: "Data Collection", labelImage: "shield")
                    ) {
                        Divider().padding(.vertical, 4)
                        
                        Text("You can toggle data collection on and off here.\n\nThis app uses Google Firebase and has the ability to collect user data if permitted. See full details in the Privacy Policy, below.")
                            .padding(.vertical, 8)
                            .frame(minHeight: 60)
                            .layoutPriority(1)
                            .font(.footnote)
                            .multilineTextAlignment(.leading)
                        
                        Toggle(isOn: $userDataAccept) {
                            if userDataAccept {
                                Text("\(toggleAction(state: userDataAccept))".uppercased())
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("AccentColor"))
                            } else {
                                Text("\(toggleAction(state: userDataAccept))".uppercased())
                                    .fontWeight(.bold)
                                    .foregroundColor(.secondary)
                            }
                            
                        }
                        .padding()
                        .background(
                            Color(UIColor.tertiarySystemBackground)
                                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                        )
                        .toggleStyle(SwitchToggleStyle(tint: Color("AccentColor")))
                    }
                    
                    // MARK: - SECTION 3
                    GroupBox(
                        label: SettingsLabelView(labelText: "Application", labelImage: "apps.iphone")
                    ) {
                        SettingsRowView(name: "Developer", content: "CryptoByNight")
                        SettingsRowView(name: "Designer", content: "CryptoByNight")
                        SettingsRowView(name: "Compatibility", content: "iOS 15")
                        SettingsRowView(name: "App Website", linkLabel: "HappySnapp", linkDestination: "happysnapp.netlify.app")
                        SettingsRowView(name: "Privacy Policy", linkLabel: "Privacy", linkDestination: "app-privacy-policy-generator.firebaseapp.com/")
                        SettingsRowView(name: "Terms & Conditions", linkLabel: "Terms", linkDestination: "app-privacy-policy-generator.firebaseapp.com/")
                        SettingsRowView(name: "Photo License", linkLabel: "Pexels", linkDestination: "www.pexels.com/license/")
                        SettingsRowView(name: "SwiftUI", content: "2.0")
                        SettingsRowView(name: "Version", content: "1.0")
                        SettingsRowView(name: "Inspiration", content: "Amanda and Lukas")
                    }
                    
                } //: VSTACK
                .navigationBarTitle("")
                .navigationBarHidden(true)
            } //: VSTACK
        } //: SCROLL VIEW
    } //: NAVIGATION VIEW
    
    func toggleAction(state: Bool) -> String {
        if state {
            Analytics.setAnalyticsCollectionEnabled(true)
            return "ON"
        } else {
            Analytics.setAnalyticsCollectionEnabled(false)
            return "OFF"
        }
        
    }
    
}


struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
