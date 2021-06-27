//
//  ContentView.swift
//  myPizza
//
//  Created by Matteo on 27/06/2021.
//

import SwiftUI


struct ContentView: View {
    @ObservedObject var order = Order()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Choose your Pizza", selection: $order.type) {
                        ForEach(0..<Order.types.count) { pizza in
                            Text(Order.types[pizza])
                        }
                    }
                    
                    Stepper(value: $order.quantity, in: 1...12) {
                        Text("Ordering \(order.quantity) pizza\(order.quantity == 1 ? "" : "s")")
                    }
                }
                
                Section {
                    Toggle(isOn: $order.additionalRequestEnabled.animation()) {
                        Text("Extras")
                    }
                    
                    if order.additionalRequestEnabled {
                        Toggle(isOn: $order.extraMozzarella) {
                            Text("Add extra mozzarella on top.")
                        }
                        
                        Toggle(isOn: $order.chillyPepperOil) {
                            Text("Add Chilly Pepper Extra spicy Olive Oil on top.")
                        }
                    }
                }
                
                NavigationLink(destination: AddressView(order: order)) {
                    Text("Delivery address")
                }
            }
            .navigationBarTitle("myPizza")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
