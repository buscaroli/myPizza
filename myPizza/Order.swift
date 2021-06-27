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
        "Funghi",
        "Contadina",
        "Capricciosa",
        "Boscaiola",
        "Nutella"
        ]
    
    static let sizes =
        [
        "small",
        "medium",
        "large",
        "One meter of Pizza"
        ]
    
    @Published var selectedType = 0
    @Published var selectedSize = 1
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
    
    var price: Double {
        
        var price: Double
        
        switch Order.sizes[selectedSize] {
        case "small":
            price = 4.00
        case "medium":
            price = 5.00
        case "large":
            price = 6.00
        default:
            price = 10.00
        }
        
        switch Order.types[selectedType] {
        case "Margherita":
            price += 0.00
        case "Marinara", "Nutella":
            price -= 0.50
        case "Contadina", "Funghi":
            price += 1.00
        default:
            price += 2.0
        }
        
        if extraMozzarella == true {
            price += 1.50
        }
        
        return price * Double(quantity)
    }
    
    
}
