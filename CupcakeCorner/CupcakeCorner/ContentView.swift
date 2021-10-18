//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Pogos Anesyan on 21.09.2021.
//

import SwiftUI

struct ContentView: View {

	@ObservedObject var order = Order()

	var body: some View {
		NavigationView {
			Form {
				Section {
					Picker("Select your cake type", selection: $order.orderValues.type) {
						ForEach(0..<Order.types.count) {
							Text(Order.types[$0])
						}
					}

					Stepper(value: $order.orderValues.quantity, in: 3...20) {
						Text("Number of cakes: \(order.orderValues.quantity)")
					}
				}

				Section {
					Toggle(isOn: $order.orderValues.specialRequestEnabled.animation()) {
						Text("Any special request ?")
					}

					if order.orderValues.specialRequestEnabled {
						Toggle(isOn: $order.orderValues.extraFrosting) {
							Text("Add extra frosting")
						}
						
						Toggle(isOn: $order.orderValues.addSprinkles) {
							Text("Add extra sprinkles")
						}
					}

//					My solution
//					Group {
//						Toggle(isOn: $order.extraFrosting) {
//							Text("Add extra frosting")
//						}
//
//						Toggle(isOn: $order.addSprinkles) {
//							Text("Add extra sprinkles")
//						}
//					}.disabled(!order.specialRequestEnabled)

					Section {
						NavigationLink(destination: AddressView(order: order)) {
							Text("Delivery details")
						}
					}
				}
			}
			.navigationTitle("Cupcake Corner")
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
