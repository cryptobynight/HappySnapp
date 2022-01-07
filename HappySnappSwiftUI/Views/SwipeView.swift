//
//  SwipeView.swift
//  HappySnapp_v2
//
//  Created by CryptoByNight on 05/10/2020.
//

import SwiftUI
import GoogleMobileAds
import SystemConfiguration

struct SwipeView: View {
    
    @AppStorage("userDataAccept") var userDataAccept = false
    @State var interstitial: GADInterstitial!
    @State private var isAnimated: Bool = false
    @ObservedObject var imageList = NetworkManager()
    @ObservedObject var taskListVM = TaskListViewModel()
    @State private var arrayNum: Int = 0
    @State private var catArray: [String] = []
    @State private var messageDisplay = 0
    @State private var textVisible = true
    @State private var buttonDisabled = false
    @State private var showAlert = false
    private let connection = SCNetworkReachabilityCreateWithName(nil, "www.apple.com")
    @State private var message = [
        "Ahh...ssst...push it.\n\nPush it good.",
        "Wow...that was anticlimactic. You need to make sure you pluck your HeartStrings first otherwise there won't be any photos.\n\nYou can go ahead and press it again if you don't believe me.",
        "Told you...",
        "Ok, you should probably pull those HeartStrings now.",
        "It's just on the bottom left.",
        "If this is making you happy then I'm all for it, but it's about to loop back to the start.\n\nHave fun!",
        "That last part was a lie. You have now reached the hidden app area. Brilliant! Yes, that's it...but wasn't it fun getting here?\n\nOk back to the start now...for real.\n\npssssst...if you press the button again nobody will know but us.",
        "LOL I knew it! I am literally laughing out loud as I type this.\n\nOk seriously though, go get a smile on your face!"
    ]
    
    private func getCardWidth(_ geometry: GeometryProxy, id: Int) -> CGFloat {
        let offset: CGFloat = CGFloat(imageList.imageList.count - 1 - id) * 10
        return geometry.size.width - offset
    }
    
    private func getCardOffset(_ geometry: GeometryProxy, id: Int) -> CGFloat {
        return  CGFloat(imageList.imageList.count - 1 - id) * 10
    }
    
    private var maxID: Int {
        return self.imageList.imageList.map { ($0.fetchArrayNum ?? 0) }.max() ?? 0
    }
    
    var body: some View {
        
        ZStack {
            Color("background").edgesIgnoringSafeArea(.all)
            
            Button(action: {
                
                var flags = SCNetworkReachabilityFlags()
                SCNetworkReachabilityGetFlags(self.connection!, &flags)
                
                if self.networkStatus(with: flags) {
                    
                    selectedCategories()
                    
                    if let searchTerm = catArray.randomElement() {
                        imageList.fetchData(category: searchTerm)
                        textVisible = false
                        if self.interstitial.isReady {
                            
                            let root = UIApplication.shared.windows.first?.rootViewController
                            self.interstitial.present(fromRootViewController: root!)
                            
                        } else {
                            print("NOT READY")
                        }
                        buttonDisabled = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                            buttonDisabled = false
                        }
                    } else {
                        if messageDisplay < message.count-1 {
                            messageDisplay += 1
                            textVisible = true
                        } else {
                            messageDisplay = 0
                            textVisible = true
                        }
                    }
                } else {
                    self.showAlert = true
                }
                
            }) {
                
                
                MyImageView(name: "HS_PDF", contentMode: .scaleAspectFit)
                    .frame(width: 200, height: 200, alignment: .center)
                    .shadow(color: Color.black, radius: 10, x: 20, y: 20)
                
//                Image("HS_640")
//                    .resizable()
//                    .frame(width: 200, height: 200, alignment: .center)
//                    .shadow(color: Color.black, radius: 10, x: 20, y: 20)
                
            }
            .disabled(buttonDisabled)
            
            VStack {
                
                Spacer()
                
                if textVisible {
                    Text(message[messageDisplay])
                        .font(.system(.headline, design: .rounded))
                        .multilineTextAlignment(.center)
                        //.padding(.top, 20)
                        .padding(.horizontal)
                        .foregroundColor(Color("AccentColor"))
                        .opacity(isAnimated ? 1 : 0)
                        .offset(y: isAnimated ? 0 : -50)
                        .animation(.easeOut(duration: 1.5))
                        .onAppear(perform: {
                            self.isAnimated.toggle()
                            self.messageDisplay = 0
                        })
                        .onDisappear() {
                            self.isAnimated.toggle()
                        }
                } else {
                    Text("Ahh...ssst...push it.\n\nPush it good.")
                        .font(.system(.headline, design: .rounded))
                        .multilineTextAlignment(.center)
                        //.padding(.top, 20)
                        .padding(.horizontal)
                        .foregroundColor(Color("AccentColor"))
                        .opacity(isAnimated ? 1 : 0)
                        .offset(y: isAnimated ? 0 : -50)
                        .animation(.easeOut(duration: 1.5))
                        .onAppear(perform: {
                            self.isAnimated.toggle()
                            self.messageDisplay = 0
                        })
                        .onDisappear() {
                            self.isAnimated.toggle()
                        }
                }
                
                Spacer()
                
            } //: VSTACK
            .offset(y: 220)
            .padding(.bottom, 20)
            
            
            
            VStack(alignment: .center, spacing: 10) {
                
                GeometryReader { geometry in
                    
                    VStack {
                        // MARK: - HEADER
                        HeaderView()
                        
                        Spacer()
                        
                        // MARK: - CARDS
                        ZStack {
                            
                            ForEach(self.imageList.imageList, id: \.self.fetchArrayNum) { image in
                                
                                VStack {
                                    
                                    // Range Operator
                                    if (self.maxID - 3)...self.maxID ~= image.fetchArrayNum! {
                                        SwipeCardView(image: image, onRemove: { removedUser in
                                            // Remove that user from our array
                                            self.imageList.imageList.removeAll { $0.id == removedUser.id }
                                        })
                                        .animation(.spring())
                                        .frame(width: self.getCardWidth(geometry, id: image.fetchArrayNum!))
                                        .offset(x: 0, y: self.getCardOffset(geometry, id: image.fetchArrayNum!))
                                    }
                                    
                                }
                                .padding(.bottom, 60)
                                
                            } //: FOR EACH
                            
                        } //: ZSTACK
                    } //: VSTACK
                    
                } //: GEOMETRY READER
            } //: VSTACK
            .padding(.horizontal, 12)
        } //: ZSTACK
        .alert(isPresented: $showAlert, content: {
            Alert(title: Text("No Internet Connection"), message: Text("Please enable wifi or cellular data to see new images."), dismissButton: .default(Text("Dismiss")))
        })
        .onAppear() {
            textVisible = true
            
            updateInterstitial()
            
        }
        
    }
    
    private func networkStatus(with flags: SCNetworkReachabilityFlags) -> Bool {
        
        let isConnected = flags.contains(.reachable)
        let notConnected = flags.contains(.connectionRequired)
        let connectAutomatically = flags.contains(.connectionOnDemand) || flags.contains(.connectionOnTraffic)
        let canConnect = connectAutomatically && !flags.contains(.interventionRequired)
        
        return isConnected && (!notConnected || canConnect)
        
    }
    
    func updateInterstitial() {
        self.interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910")
        let request = GADRequest()
        self.interstitial.load(request)
    }
    
    func removeCard(at index: Int) {
        imageList.imageList.remove(at: index)
    }
    
    func selectedCategories() {
        
        self.catArray = []
        
        for category in taskListVM.taskCellViewModels {
            if category.task.selected {
                self.catArray.append(category.task.searchName)
            }
        }
    }
    
}


struct SwipeView_Previews: PreviewProvider {
    static var previews: some View {
        SwipeView()
    }
}
