//
//  MyImageView.swift
//  HappySnappSwiftUI
//
//  Created by CryptoByNight on 21/11/2020.
//

import SwiftUI

struct MyImageView: UIViewRepresentable {
  var name: String
  var contentMode: UIView.ContentMode = .scaleAspectFit
  var tintColor: UIColor = .black

  func makeUIView(context: Context) -> UIImageView {
    let imageView = UIImageView()
    imageView.setContentCompressionResistancePriority(.fittingSizeLevel,
                                                      for: .vertical)
    return imageView
  }

  func updateUIView(_ uiView: UIImageView, context: Context) {
    uiView.contentMode = contentMode
    uiView.tintColor = tintColor
    if let image = UIImage(named: name) {
      uiView.image = image
    }
  }
}
