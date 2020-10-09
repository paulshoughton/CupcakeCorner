//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Paul Houghton on 07/10/2020.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: Order
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.theOrder.name)
                TextField("Street Address", text: $order.theOrder.streetAddress)
                TextField("City", text: $order.theOrder.city)
                TextField("ZIP", text: $order.theOrder.zip)
            }
            
            Section {
                NavigationLink(destination: CheckoutView(order: order)) {
                    Text("Check out")
                }
            }
            .disabled(order.theOrder.hasValidAddress == false)
        }
        .navigationBarTitle("Delivery details", displayMode: .inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: Order())
    }
}
