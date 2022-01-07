//
//  FavCardView.swift
//  HappySnapp_v2
//
//  Created by CryptoByNight on 05/10/2020.
//

//import SwiftUI
//import SDWebImageSwiftUI
//import GoogleMobileAds
//import SystemConfiguration
//
//enum ActiveSheetFav: Identifiable {
//    case footer, shareScreen
//    
//    var id: Int {
//        hashValue
//    }
//}
//
//struct FavCardView: View {
//    
//    var card: Picture
//    
//    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
//    
//    @ObservedObject var favListVM = FavouritesListViewModel()
//    @State private var activeSheetFav: ActiveSheetFav?
//    @State private var showAlert = false
//    private let connection = SCNetworkReachabilityCreateWithName(nil, "www.apple.com")
//    
//    var body: some View {
//        
//        VStack(alignment: .center) {
//            
//            Spacer()
//            
//            WebImage(url: URL(string: card.fireURL))
//                .resizable()
//                .indicator(.activity)
//                .scaledToFit()
//                .contextMenu {
//                    VStack {
//                        
//                        Button(action: {
//                            
//                            var flags = SCNetworkReachabilityFlags()
//                            SCNetworkReachabilityGetFlags(self.connection!, &flags)
//                            
//                            if self.networkStatus(with: flags) {
//                                activeSheetFav = .shareScreen
//                            } else {
//                                self.showAlert = true
//                            }
//                            
//                        }) {
//                            
//                            HStack{
//                                Text("Share")
//                                Spacer()
//                                Image(systemName: "square.and.arrow.up.fill")
//                            }
//                            .foregroundColor(.black)
//                        }
//                    } //: VSTACK
//                    
//                } //: CONTEXT MENU
//            
////            Spacer()
////            
////            Button(action: {
////                
////                var flags = SCNetworkReachabilityFlags()
////                SCNetworkReachabilityGetFlags(self.connection!, &flags)
////                
////                if self.networkStatus(with: flags) {
////                    activeSheetFav = .footer
////                } else {
////                    self.showAlert = true
////                }
////                
////            }) {
////                VStack {
////                    Text(card.photographer)
////                        .foregroundColor(Color("background"))
////                        .fontWeight(.bold)
////                        .multilineTextAlignment(.center)
////                        .padding(.horizontal)
////                        .padding(.vertical, 4)
////                        .overlay(
////                            Rectangle()
////                                .fill(Color("background"))
////                                .frame(height: 1), alignment: .bottom
////                        )
////                    
////                    Text("Artist Page  \(Image(systemName: "link"))")
////                        .foregroundColor(Color("background"))
////                        //.font(Font.custom("BPchildFatty", size: 15))
////                        .multilineTextAlignment(.center)
////                        .padding(.horizontal, 8)
////                        .padding(.bottom, 5)
////                }
////                .frame(minWidth: 350)
//                
////            } //: BUTTON
////            .background(Capsule().fill(Color("AccentColor")))
//           
//            HStack {
//                Text(card.photographer)
//                    .foregroundColor(Color("AccentColor"))
//                    .multilineTextAlignment(.leading)
//                    .opacity(0.7)
//                
//                Spacer()
//            }.padding(.horizontal, 10)
//            
//            
//            Spacer()
//            
//            BannerViewFavCard()
//                .frame(minWidth: 100, idealWidth: 320, maxWidth: .infinity, minHeight: 50, idealHeight: 50, maxHeight: 70, alignment: .center)
//            
//        } //: VSTACK
//        .sheet(item: $activeSheetFav) { item in
//            
//            switch item {
//            case .shareScreen:
//                if let imageURL = URL(string: card.fireURL) {
//                    
//                    if let imageData = try? Data(contentsOf: imageURL) {
//                        if let image = UIImage(data: imageData) {
//                            ActivityView(activityItems: [image])
//                        }
//                    }
//                }
//            case .footer:
//                ArtistPageView(url: card.photographer_url)
//            }
//            
//        }
//        .alert(isPresented: $showAlert, content: {
//            Alert(title: Text("No Internet Connection"), message: Text("Please enable wifi or cellular data to download/share images and view artist pages."), dismissButton: .default(Text("Dismiss")))
//        })
//        .navigationBarTitle("HAPPY SNAPP", displayMode: .inline)
//        .navigationBarItems(
//            
//            trailing: Button(action: {
//                
//                presentationMode.wrappedValue.dismiss()
//                
//                favListVM.removeFavs(fav: card)
//                
//            }) {
//                Image(systemName: "trash.fill")
//            }) //: BUTTON
//        
//    }
//    
//    private func networkStatus(with flags: SCNetworkReachabilityFlags) -> Bool {
//        
//        let isConnected = flags.contains(.reachable)
//        let notConnected = flags.contains(.connectionRequired)
//        let connectAutomatically = flags.contains(.connectionOnDemand) || flags.contains(.connectionOnTraffic)
//        let canConnect = connectAutomatically && !flags.contains(.interventionRequired)
//        
//        return isConnected && (!notConnected || canConnect)
//        
//    }
//    
//}
//
//struct BannerViewFavCard: UIViewRepresentable {
//    
//    func makeUIView(context: UIViewRepresentableContext<BannerViewFavCard>) -> GADBannerView {
//        
//        let banner = GADBannerView(adSize: kGADAdSizeBanner)
//        banner.adUnitID = ""
//        banner.rootViewController = UIApplication.shared.windows.first?.rootViewController
//        banner.load(GADRequest())
//        return banner
//        //ca-app-pub-6662078691271356/5457998206
//    }
//    
//    func updateUIView(_ uiView: GADBannerView, context: UIViewRepresentableContext<BannerViewFavCard>) {
//        
//    }
//    
//}
