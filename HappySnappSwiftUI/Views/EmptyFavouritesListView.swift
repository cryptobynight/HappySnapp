//
//  EmptyFavouritesListView.swift
//  HappySnapp_v2
//
//  Created by CryptoByNight on 05/10/2020.
//

import SwiftUI

struct EmptyFavouritesListView: View {
    
    @State private var isAnimated: Bool = false
    
    let tips: [String] = [
        "Pick some favourites and fill this up!",
        "Treat yourself to some eye candy.",
        "Nothing is worth having a bad day. Put some smiles in this folder."
    ]
    
    var body: some View {
        ZStack {
            VStack {
                Image("640")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250, alignment: .center)
                    .layoutPriority(1.0)
                    .shadow(radius: 20)
                
                //Text("\(tips.randomElement() ?? self.tips[0])")
                Text("Add some happy snapps. You're the boss and there's no right or wrong.")
                    .layoutPriority(0.5)
                    .font(.system(.headline, design: .rounded))
                    .padding(.top, 30)
            } //: VSTACK
            .padding(.horizontal)
            .foregroundColor(Color("AccentColor"))
            .opacity(isAnimated ? 1 : 0)
            .offset(y: isAnimated ? 0 : -50)
            .animation(.easeOut(duration: 1.5))
            .onAppear(perform: {
                self.isAnimated.toggle()
            })
            .onDisappear() {
                self.isAnimated.toggle()
            }
        } //: ZSTACK
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(Color("background"))
        .edgesIgnoringSafeArea(.all)
    }
}

struct EmptyFavouritesListView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyFavouritesListView()
    }
}

