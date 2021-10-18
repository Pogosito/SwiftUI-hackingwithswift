//
//  AddressView.swift
//  AddressView
//
//  Created by Pogos Anesyan on 02.10.2021.
//

import SwiftUI

struct AddressView: View {

	@ObservedObject var order: Order

	var body: some View {
		Form {
			Section {
				TextField("Name", text: $order.orderValues.name)
				TextField("Street address", text: $order.orderValues.streetAddress)
				TextField("City", text: $order.orderValues.city)
				TextField("Zip", text: $order.orderValues.zip)
			}

			Section {
				NavigationLink(destination: CheckoutView(order: order)) {
					Text("Check out")
				}
			}.disabled(!order.hasValidAddress)
		}
		.navigationTitle("Delivery details")
		.navigationBarTitleDisplayMode(.inline)
	}
}

struct AddressView_Previews: PreviewProvider {
	static var previews: some View {
		AddressView(order: Order())
	}
}
