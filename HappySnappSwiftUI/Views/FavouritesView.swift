//
//  FavouritesView.swift
//  HappySnapp_v2
//
//  Created by CryptoByNight on 05/10/2020.
//

import SwiftUI
import SDWebImageSwiftUI
import UIKit
import GoogleMobileAds
import SystemConfiguration

struct FavouritesView: View {
    @State var columns: CGFloat = 2
    @ObservedObject var favouritesListVM = FavouritesListViewModel()
    
    var dynamicLayout: [GridItem] {
        Array(repeating: GridItem(.flexible()), count: Int(columns))
    }
    
//    init() {
//
//        let appearance = UINavigationBarAppearance()
//        appearance.configureWithTransparentBackground()
//        appearance.largeTitleTextAttributes = [
//            .font : UIFont(name: "BPchildFatty", size: 20)!,
//            NSAttributedString.Key.foregroundColor : UIColor(Color("AccentColor"))
//        ]
//        appearance.titleTextAttributes = [
//            .font : UIFont(name: "BPchildFatty", size: 20)!,
//            NSAttributedString.Key.foregroundColor : UIColor(Color("AccentColor"))
//        ]
//        UINavigationBar.appearance().scrollEdgeAppearance = appearance
//        UINavigationBar.appearance().standardAppearance = appearance
//
//        //UINavigationBar.appearance().tintColor = .white
//
//    }
    
    var body: some View {
        
        GeometryReader { geo in
                
                ZStack {
                    Color("background").edgesIgnoringSafeArea(.all)
                    
                    VStack {
                        
                        BannerView()
                            .frame(minWidth: 100, idealWidth: 400, maxWidth: .infinity, minHeight: 50, idealHeight: 50, maxHeight: 70, alignment: .center)
                        
                        
                        ScrollView {
                            LazyVGrid(columns: dynamicLayout) {
                                ForEach(favouritesListVM.favouritesCellViewModels) { favouriteCellVM in
                                    FavouritesCell(favCellVM: favouriteCellVM, geo: geo, columns: columns, dynamic: dynamicLayout)
                                    
                                    
                                } //: FOR EACH
                                
                            } //: LAZY V GRID
                            .animation(.default)
                        } // :SCROLL
                        
                        
                        Text("Smile Slider: \(Int(columns))x")
                            .foregroundColor(Color("AccentColor"))
                            .fontWeight(.bold)
                        //.font(Font.custom("BPchildFatty", size: 25))
                        Slider(value: $columns, in: 1...5)
                            .padding(.horizontal)
                            .padding(.vertical, 2)
                            .accentColor(Color("AccentColor"))
                            .overlay(
                                RoundedRectangle(cornerRadius: 15.0)
                                    .stroke(lineWidth: 2.0)
                                    .foregroundColor(Color("AccentColor"))
                            )
                            .padding(.vertical, 7)
                            .padding(.horizontal)
                        
                    } //: VSTACK
                    .padding(.horizontal, 5)
                    
                    if favouritesListVM.favouritesCellViewModels.isEmpty {
                        EmptyFavouritesListView()
                    }
                } //: ZSTACK
                .navigationTitle("")
                .navigationBarHidden(true)
                .onAppear() {
                }
//            } //: NAVIGATION
//            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

struct FavouritesCell: View {
    
    var favCellVM: FavouritesCellViewModel
    var geo: GeometryProxy
    var columns: CGFloat
    var dynamic: [GridItem]
    @ObservedObject var favListVM = FavouritesListViewModel()
    //let dlTrigger = DownloadTrigger()
    @State private var showShare = false
    @State private var showAlert = false
    @State var interstitial: GADInterstitial!
    private let connection = SCNetworkReachabilityCreateWithName(nil, "www.apple.com")
    
    var body: some View {
        
        ZStack(alignment: .bottomTrailing) {
            
//            NavigationLink(destination: FavCardView(card: favCellVM.favourite)) {
                
                WebImage(url: URL(string: favCellVM.favourite.fireURL))
                    .resizable()
                    .indicator(.activity)
                    .scaledToFill()
                    .frame(width: (geo.size.width-15)/CGFloat(dynamic.count), height: (geo.size.width-15)/CGFloat(dynamic.count))
                    .cornerRadius(20)
                    .overlay(
                        VStack{
                            Spacer()
                            HStack {
                                Text(favCellVM.favourite.photographer)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .shadow(color: Color.black, radius: 7, x: 2, y: 2)
                                    .opacity(columns < 2 ? 1.0 : 0.0)
                                Spacer()
                            }.padding(.leading, 8)
                        }.padding(.bottom, 8)
                    )
                    .contextMenu {
                        VStack {
                            
                            Button(action: {
                                
                                var flags = SCNetworkReachabilityFlags()
                                SCNetworkReachabilityGetFlags(self.connection!, &flags)
                                
                                if self.networkStatus(with: flags) {
                                    self.showShare = true
                                } else {
                                    self.showAlert = true
                                }
                                
                                
                                
                            }) {
                                
                                HStack{
                                    Text("Share")
                                    Spacer()
                                    Image(systemName: "square.and.arrow.up.fill")
                                }
                                .foregroundColor(.black)
                                
                            }
                            
                            Button(action: {
                                
                                favListVM.removeFavs(fav: favCellVM.favourite)
                                
                            }) {
                                HStack{
                                    Text("Delete")
                                    Spacer()
                                    Image(systemName: "trash.fill")
                                }
                                .foregroundColor(.black)
                            }
                            
                        } //: VSTACK
                        
                    } //: CONTEXT MENU
                
//            } //: NAVIGATION LINK
            
        } //: ZSTACK
        .sheet(isPresented: $showShare, content: {
            if let imageURL = URL(string: favCellVM.favourite.fireURL) {
                
                if let imageData = try? Data(contentsOf: imageURL) {
                    if let image = UIImage(data: imageData) {
                        ActivityView(activityItems: [image])
                    }
                }
            }
        })
        .alert(isPresented: $showAlert, content: {
            Alert(title: Text("No Internet Connection"), message: Text("Please enable wifi or cellular data to download and share images."), dismissButton: .default(Text("Dismiss")))
        })
    }
    
    private func networkStatus(with flags: SCNetworkReachabilityFlags) -> Bool {
        
        let isConnected = flags.contains(.reachable)
        let notConnected = flags.contains(.connectionRequired)
        let connectAutomatically = flags.contains(.connectionOnDemand) || flags.contains(.connectionOnTraffic)
        let canConnect = connectAutomatically && !flags.contains(.interventionRequired)
        
        return isConnected && (!notConnected || canConnect)
        
    }
    
}

struct FavouritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesView()
    }
}

struct BannerView: UIViewRepresentable {
    
    func makeUIView(context: UIViewRepresentableContext<BannerView>) -> GADBannerView {
        
        let banner = GADBannerView(adSize: kGADAdSizeBanner)
        banner.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        banner.rootViewController = UIApplication.shared.windows.first?.rootViewController
        banner.load(GADRequest())
        return banner
    }
    
    func updateUIView(_ uiView: GADBannerView, context: UIViewRepresentableContext<BannerView>) {
        
    }
    
}
