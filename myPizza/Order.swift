//
//  Order.swift
//  myPizza
//
//  Created by Matteo on 27/06/2021.
//

import Foundation

class Order: ObservableObject, Codable {
    // A class with @Published properties doesn't automatically conform to the Codable protocol.
    // We need to make the class conform to it by hand.
    enum CodingKeys: CodingKey {
        case selectedType, selectedSize, quantity, additionalRequestEnabled,
             extraMozzarella, chillyPepperOil, customerName, streetAddress,
             city, postcode
        
    }
    
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
    
    // Without this empty initializer, COntentView would raise an Error as we start the view with
    // an empty Order() and it would expect to have a 'from' argument.
    init() { }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        selectedType = try container.decode(Int.self, forKey: .selectedType)
        selectedSize = try container.decode(Int.self, forKey: .selectedSize)
        quantity = try container.decode(Int.self, forKey: .quantity)
        additionalRequestEnabled = try container.decode(Bool.self, forKey: .additionalRequestEnabled)
        extraMozzarella = try container.decode(Bool.self, forKey: .extraMozzarella)
        chillyPepperOil = try container.decode(Bool.self, forKey: .chillyPepperOil)
        customerName = try container.decode(String.self, forKey: .customerName)
        streetAddress = try container.decode(String.self, forKey: .streetAddress)
        city = try container.decode(String.self, forKey: .city)
        postcode = try container.decode(String.self, forKey: .postcode)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(selectedType, forKey: .selectedType)
        try container.encode(selectedSize, forKey: .selectedSize)
        try container.encode(quantity, forKey: .quantity)
        try container.encode(additionalRequestEnabled, forKey: .additionalRequestEnabled)
        try container.encode(extraMozzarella, forKey: .extraMozzarella)
        try container.encode(chillyPepperOil, forKey: .chillyPepperOil)
        try container.encode(customerName, forKey: .customerName)
        try container.encode(streetAddress, forKey: .streetAddress)
        try container.encode(city, forKey: .city)
        try container.encode(postcode, forKey: .postcode)
    }
    
    
}
