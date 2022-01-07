//
//  HeaderComponent.swift
//  HappySnapp_v2
//
//  Created by CryptoByNight on 05/10/2020.
//

import SwiftUI

struct HeaderComponent: View {
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Capsule()
                .frame(width: 120, height: 6)
                .foregroundColor(.secondary)
                .opacity(0.2)
            
            Text("HAPPY SNAPP")
                .font(Font.custom("BPchildFatty", size: 40))
                .multilineTextAlignment(.center)
                .frame(height: 50)
                .foregroundColor(Color("AccentColor"))
        }
    }
}

struct HeaderComponent_Previews: PreviewProvider {
    static var previews: some View {
        HeaderComponent()
    }
}
