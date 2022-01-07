//
//  Picture.swift
//  HappySnapp_v2
//
//  Created by CryptoByNight on 05/10/2020.
//

import Foundation
import FirebaseFirestoreSwift

struct Picture: Codable, Identifiable {
    var id: String
    let photographer: String
    let photographer_url: String
    var category: String
    let fireURL: String
    let storageName: String
    var fetchArrayNum: Int?
    var userId: String?
    var timeStamp: TimeInterval?
}

let testDataPictures: [Picture] = []

