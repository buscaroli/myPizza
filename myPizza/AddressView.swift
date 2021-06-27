//
//  AddressView.swift
//  myPizza
//
//  Created by Matteo on 27/06/2021.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: Order
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.customerName)
                TextField("Street Address", text: $order.streetAddress)
                TextField("City", text: $order.city)
                TextField("Post Code", text: $order.postcode)
            }
            
            Section {
                NavigationLink(destination: CheckOutView(order: order)) {
                    Text("Check Out")
                }
            }
            .disabled(order.hasValidAddress == false)
        }
        .navigationBarTitle("Delivery details", displayMode: .inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: Order())
    }
}
