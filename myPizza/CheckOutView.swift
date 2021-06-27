//
//  CheckOutView.swift
//  myPizza
//
//  Created by Matteo on 27/06/2021.
//
// Photo by <a href="https://unsplash.com/@lyndaann1975?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Lynda Hinton</a> on <a href="https://unsplash.com/s/photos/pizzas?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>


import SwiftUI

struct CheckOutView: View {
    @ObservedObject var order: Order
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                VStack {
                    Image("pizza")
                        .resizable()
                        .scaledToFit()
                        .frame(width: proxy.size.width)
                        .overlay(Text("Photo by Lynda Hinton")
                                    .foregroundColor(.white)
                                    .font(.caption)
                                    .padding(3),
                                 alignment: .bottomTrailing)
                            
                    Text("Your order is £\(self.order.price, specifier: "%.2f")")
                        .font(.title)
                    
                    Button("Place Order") {
                        print("Order Placed!")
                    }
                    .padding()
                }
            }
        }
        .navigationBarTitle("Check Out", displayMode: .inline)
    }
}

struct CheckOutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckOutView(order: Order())
    }
}
