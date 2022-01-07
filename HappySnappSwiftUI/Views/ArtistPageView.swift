//
//  ArtistPageView.swift
//  HappySnapp_v2
//
//  Created by CryptoByNight on 05/10/2020.
//

//import SwiftUI
//
//struct ArtistPageView: View {
//    // MARK: - PROPERTIES
//    
//    @Environment(\.presentationMode) var presentationMode
//    let url: String?
//    
//    // MARK: - BODY
//    
//    var body: some View {
//        ZStack {
//            Color("background").edgesIgnoringSafeArea(.all)
//            
//            VStack {
//                HStack {
//                    
//                    Spacer()
//                    
//                    HeaderComponent()
//                    
//                    Spacer()
//                    
//                    Button(action: {
//                        presentationMode.wrappedValue.dismiss()
//                    }) {
//                        Image(systemName: "xmark")
//                            .font(.system(size: 20, weight: .bold))
//                        
//                    }
//                } //: HSTACK
//                .padding(.horizontal)
//                .padding(.vertical, 10)
//                
//                WebView(urlString: url)
//            } //: VSTACK
//        } //: ZSTACK
//    }
//}


