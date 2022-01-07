//
//  FooterView.swift
//  HappySnapp_v2
//
//  Created by CryptoByNight on 05/10/2020.
//

//import SwiftUI
//
//struct FooterView: View {
//    // MARK: - PROPERTIES
//    var picture: Picture
//    @State private var isShowingUserPage: Bool = false
//    
//    // MARK: - BODY
//    var body: some View {
//        
//        Button(action: {
//            isShowingUserPage = true
//        }) {
//            VStack {
//                Text(picture.photographer)
//                    .foregroundColor(Color("background"))
//                    //.font(Font.custom("BPchildFatty", size: 20))
//                    .fontWeight(.bold)
//                    .multilineTextAlignment(.center)
//                    .padding(.horizontal)
//                    .padding(.vertical, 4)
//                    .overlay(
//                        Rectangle()
//                            .fill(Color("background"))
//                            .frame(height: 1), alignment: .bottom
//                    )
//                
//                Text("Artist Page  \(Image(systemName: "link"))")
//                    .foregroundColor(Color("background"))
//                    .multilineTextAlignment(.center)
//                    .padding(.horizontal, 8)
//                    .padding(.bottom, 5)
//            }
//            .frame(minWidth: 350)
//            
//        } //: BUTTON
//        .background(Capsule().fill(Color("AccentColor")))
//        .sheet(isPresented: $isShowingUserPage) {
//            ArtistPageView(url: picture.photographer_url)
//        }
//    }
//}
//
//
