//
//  CheckOutView.swift
//  myPizza
//
//  Created by Matteo on 27/06/2021.
//
/*
 Photo by <a href="https://unsplash.com/@lyndaann1975?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Lynda Hinton</a> on <a href="https://unsplash.com/s/photos/pizzas?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>
 */


import SwiftUI

struct CheckOutView: View {
    @ObservedObject var order: Order
    @State private var confirmationMsg = ""
    @State private var showingConfirmationMsg = false
    
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
                        self.placeOrder()
                    }
                    .padding()
                }
            }
        }
        .navigationBarTitle("Check Out", displayMode: .inline)
        .alert(isPresented: $showingConfirmationMsg, content: {
            Alert(title: Text("Thank You!"), message: Text(confirmationMsg), dismissButton: .default(Text("OK")))
        })
    }
    
    func placeOrder() {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order.")
            return
        }
        // using reqres.in which allows us to send an HTTP request and receive the
        // code back. This way we can prototype API calls without setting up a dedicated
        // server.
        let url = URL(string: "https://reqres.in/api/myPizzas")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown Error")")
                return
            }
            
            if let decodedOrder = try? JSONDecoder().decode(Order.self, from: data) {
                self.confirmationMsg = "We'll deliver your order of \(decodedOrder.quantity) pizza \(Order.types[decodedOrder.selectedType].lowercased()) within the next 20 minutes!"
                self.showingConfirmationMsg = true
            } else {
                self.confirmationMsg = "Invalid response from server! Please ring in store."
                self.showingConfirmationMsg = true
            }
            
        }.resume()
    }
}

struct CheckOutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckOutView(order: Order())
    }
}
