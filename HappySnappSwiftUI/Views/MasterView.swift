//
//  MasterView.swift
//  HappySnapp_v2
//
//  Created by CryptoByNight on 05/10/2020.
//

import SwiftUI

struct MasterView: View {
    
    init() {
        //UITabBar.appearance().backgroundColor = UIColor(Color("background"))
        UITabBar.appearance().barTintColor = UIColor(Color("background"))
        //UITabBar.appearance().unselectedItemTintColor = UIColor(Color.secondary)
    }
    
    @State var selected = 1
    
    var body: some View {
        
        ZStack {
            TabView(selection: $selected) {
                TaskListView()
                    .tabItem {
                        Image(systemName: "heart.slash")
                            .font(.largeTitle)
                        Text("HeartStrings")
                    }.tag(0)
                
                SwipeView()
                    .tabItem {
                        Image(systemName: "photo")
                        Text("Pursuit")
                    }.tag(1)
                
                FavouritesView()
                    .tabItem {
                        Image(systemName: "smiley")
                        Text("HappySnapps")
                    }.tag(2)
                
            } //: TABVIEW
            .accentColor(Color("AccentColor"))
            
        } //: ZSTACK
        .onAppear() {
            //Only for testing:
            //AuthenticationService().signOut()
        }
    }
    
}

struct MasterView_Previews: PreviewProvider {
    static var previews: some View {
        MasterView()
    }
}
