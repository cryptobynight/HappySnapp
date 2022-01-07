//
//  SwipeCardView.swift
//  HappySnapp_v2
//
//  Created by CryptoByNight on 05/10/2020.
//

import SwiftUI
import SDWebImageSwiftUI

extension AnyTransition {
    static var trailingBottom: AnyTransition {
        AnyTransition.asymmetric(insertion: .identity, removal: AnyTransition.move(edge: .trailing).combined(with: .move(edge: .bottom)))
    }
    
    static var leadingBottom: AnyTransition {
        AnyTransition.asymmetric(insertion: .identity, removal: AnyTransition.move(edge: .leading).combined(with: .move(edge: .bottom)))
    }
}

struct SwipeCardView: View {
    
    @State private var offset = CGSize.zero
    @GestureState private var dragState = DragState.inactive
    let dragAreaThreshold: CGFloat = 65.0
    @State private var cardRemovalTransition = AnyTransition.trailingBottom
    @ObservedObject var favListVM = FavouritesListViewModel()
    
    enum DragState {
        case inactive
        case pressing
        case dragging(translation: CGSize)
        
        var translation: CGSize {
            switch self {
            case .inactive, .pressing:
                return .zero
            case .dragging(let translation):
                return translation
            }
        }
        
        var isDragging: Bool {
            switch self {
            case .dragging:
                return true
            case .pressing, .inactive:
                return false
            }
        }
        
        var isPressing: Bool {
            switch self {
            case .pressing, .dragging:
                return true
            case .inactive:
                return false
            }
        }
    }
    
    private var image: Picture
    private var onRemove: (_ user: Picture) -> Void
    
    
    init(image: Picture, onRemove: @escaping (_ image: Picture) -> Void) {
        self.image = image
        self.onRemove = onRemove
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                
                WebImage(url: URL(string: self.image.fireURL))
                    .resizable()
                    .placeholder(Image("loadingscreen"))
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .clipped()
                    .padding(.bottom, 10)
                    .background(Color("cardBottom"))
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .overlay(
                        ZStack {
                            // THUMBS DOWN SYMBOL
                            Image(uiImage: UIImage(named: "xmarkSVG")!)
                                .resizable()
                                .scaledToFit()
                                .padding()
                                .shadow(radius: 20)
                                .opacity(self.dragState.translation.width < -self.dragAreaThreshold ? 0.6 : 0.0)
                            
                            // SMILEY SYMBOL
                            Image("1280")
                                .resizable()
                                .scaledToFit()
                                .padding()
                                .shadow(radius: 20)
                                .opacity(self.dragState.translation.width > self.dragAreaThreshold ? 1.0 : 0.0)
                            
//                            VStack {
//                                Spacer()
//                                HStack {
//                                    Text(self.image.photographer)
//                                        .fontWeight(.bold)
//                                        .shadow(color: Color.black, radius: 10, x: 0, y: 0)
//                                    Spacer()
//                                }.padding(.horizontal, 5)
//                            }
//                            .padding(.bottom, 10)
                        }
                    )
                    .offset(x: self.dragState.translation.width, y: self.dragState.translation.height)
                    .scaleEffect(self.dragState.isDragging ? 0.85 : 1.0)
                    //.rotationEffect(Angle(degrees: Double(self.dragState.translation.width / 12)))
                    .rotationEffect(.degrees(Double(self.dragState.translation.width / geometry.size.width) * 25), anchor: .bottom)
                    .animation(.interpolatingSpring(stiffness: 120, damping: 120))
                    //.animation(.interactiveSpring())
                    .gesture(LongPressGesture(minimumDuration: 0.01)
                                .sequenced(before: DragGesture())
                                .updating(self.$dragState, body: { (value, state, transaction) in
                                    switch value {
                                    case .first(true):
                                        state = .pressing
                                    case .second(true, let drag):
                                        state = .dragging(translation: drag?.translation ?? .zero)
                                    default:
                                        break
                                    }
                                })
                                .onChanged({ (value) in
                                    
                                    guard case .second(true, let drag?) = value else {
                                        return
                                    }
                                    
                                    if drag.translation.width < -self.dragAreaThreshold {
                                        self.cardRemovalTransition = .leadingBottom
                                    }
                                    
                                    if drag.translation.width > self.dragAreaThreshold {
                                        self.cardRemovalTransition = .trailingBottom
                                    }
                                    
                                })
                                .onEnded({ (value) in
                                    guard case .second(true, let drag?) = value else {
                                        return
                                    }
                                    if drag.translation.width < -self.dragAreaThreshold {
                                        self.onRemove(self.image)
                                        
                                        //print("THUMBS DOWN")
                                    } else if drag.translation.width > self.dragAreaThreshold {
                                        self.onRemove(self.image)
                                        
                                        //print("SAVE TO FAVOURITES")
                                        DispatchQueue.main.async {
                                            
                                            self.favListVM.addFav(fav: image)
                                            
                                        }
                                    }
                                })
                    ) //: GESTURE
            }
            
        }
        
    }
}



