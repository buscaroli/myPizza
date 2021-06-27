//
//  CheckOutView.swift
//  myPizza
//
//  Created by Matteo on 27/06/2021.
//

import SwiftUI

struct CheckOutView: View {
    @ObservedObject var order: Order
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct CheckOutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckOutView(order: Order())
    }
}
