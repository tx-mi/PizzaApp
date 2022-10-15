//
//  ProductModel.swift
//  PizzaApp
//
//  Created by Ramazan Abdulaev on 15.10.2022.
//

import Foundation

struct Product: Codable {
    let id: String
    let img: String
    let name: String
    let dsc: String
    let price: Double
    let rate: Int
    let country: String
}

enum Categories: String, CaseIterable {
    case getPizzas
    case getBurgers
    case getDesserts
    case getDrinks
}

extension Categories {
    
    var path: String {
        switch self {
        case .getPizzas:
            return "pizzas"
        case .getBurgers:
            return "burgers"
        case .getDesserts:
            return "desserts"
        case .getDrinks:
            return "drinks"
        }
    }
    
}

