//
//  HeaderView.swift
//  HappySnapp_v2
//
//  Created by CryptoByNight on 05/10/2020.
//

import SwiftUI

enum ActiveSheet: Identifiable {
    case settings, account
    
    var id: Int {
        hashValue
    }
}

struct HeaderView: View {
    
    @State private var activeSheet: ActiveSheet?
    
    var body: some View {
        
        HStack {
            Button(action: {
                activeSheet = .settings
                
            }) {
                Image(systemName: "slider.horizontal.3")
                    .foregroundColor(Color("AccentColor"))
            }
            
            Spacer()
            
            Text("HAPPY SNAPP")
                .font(Font.custom("BPchildFatty", size: 40))
                .multilineTextAlignment(.center)
                .frame(height: 50)
                .foregroundColor(Color("AccentColor"))
            
            Spacer()
            
            Button(action: {
                activeSheet = .account
                
            }) {
                Image(systemName: "person.circle")
                    .foregroundColor(Color("AccentColor"))
            }
            
        } //: HSTACK
        .padding(.horizontal, 5)
        .sheet(item: $activeSheet) { item in
            
            switch item {
            case .account: AccountView()
            case .settings: SettingsView()
            }
            
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
