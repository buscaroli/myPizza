//
//  Order.swift
//  myPizza
//
//  Created by Matteo on 27/06/2021.
//

import Foundation

class Order: ObservableObject {
    static let types =
        [
        "Margherita",
        "Marinara",
        "Funghi - Mushrooms",
        "Contadina - Veggies",
        "Capricciosa - Ham Mushrooms and veggies",
        "Boscaiola - Veggies and Mushrooms",
        "Nutella"
        ]
    
    static let size =
        [
        "small",
        "medium",
        "large",
        "One meter of Pizza"
        ]
    
    @Published var type = 0
    @Published var quantity = 1
    @Published var additionalRequestEnabled = false {
        didSet {
            if additionalRequestEnabled == false {
                extraMozzarella = false
                chillyPepperOil = false
            }
        }
    }
    @Published var extraMozzarella = false
    @Published var chillyPepperOil = false
    
    @Published var customerName = ""
    @Published var streetAddress = ""
    @Published var city = ""
    @Published var postcode = ""
    
    var hasValidAddress: Bool {
        if customerName.isEmpty || streetAddress.isEmpty || city.isEmpty || postcode.isEmpty {
            return false
        }
        return true
    }
    
}
