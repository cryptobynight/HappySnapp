//
//  Category.swift
//  HappySnapp_v2
//
//  Created by CryptoByNight on 04/10/2020.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Task: Codable, Identifiable {
    
    @DocumentID var id: String?
    var image: String
    var name: String
    var searchName: String
    var selected: Bool
    var arrayID: Int
    var userId: String?
}

let initialCategories = [
    
    //abstract, adventure, ocean, cityscape, macro, wildlife, vintage, art, nature, food, cute animals, flying, sports, fashion
    
    
    Task(image: "Adventure", name: "EPIC", searchName: "Adventure", selected: false, arrayID: 0),
    Task(image: "Vintage", name: "VINTAGE", searchName: "Vintage", selected: false, arrayID: 1),
    Task(image: "CuteAnimals", name: "CUTE\nANIMALS", searchName: "CuteAnimals", selected: false, arrayID: 2),
    Task(image: "Art", name: "ART", searchName: "Art", selected: false, arrayID: 3),
    Task(image: "Food", name: "FOOD", searchName: "Food", selected: false, arrayID: 4),
    Task(image: "Nature", name: "NATURE", searchName: "Nature", selected: false, arrayID: 5),
    Task(image: "Macro", name: "MACRO", searchName: "Macro", selected: false, arrayID: 6),
    Task(image: "Fashion", name: "FASHION", searchName: "Fashion", selected: false, arrayID: 7),
    Task(image: "Sports", name: "SPORTS", searchName: "Sports", selected: false, arrayID: 8),
    Task(image: "Cityscape", name: "URBAN", searchName: "Cityscape", selected: false, arrayID: 9),
    Task(image: "Ocean", name: "OCEAN", searchName: "Ocean", selected: false, arrayID: 10),
    Task(image: "Abstract", name: "ABSTRACT", searchName: "Abstract", selected: false, arrayID: 11),
    Task(image: "Wildlife", name: "WILDLIFE", searchName: "Wildlife", selected: false, arrayID: 12),
    Task(image: "Flying", name: "FLIGHT", searchName: "Flying", selected: false, arrayID: 13),
    
]



