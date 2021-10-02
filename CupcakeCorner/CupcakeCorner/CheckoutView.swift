//
//  CheckoutView.swift
//  CheckoutView
//
//  Created by Pogos Anesyan on 02.10.2021.
//

import SwiftUI

struct CheckoutView: View {

	@ObservedObject var order: Order
	lazy var price: LocalizedStringKey = "\(order.order, specifier: "%.2f")"

	var body: some View {
		GeometryReader { geo in
			ScrollView {
				VStack {
					Image("cupcakes")
						.resizable()
						.scaledToFit()
						.frame(width: geo.size.width)

					Text("$\(order.order)")
						.font(.title)

					Button("Place order") {
						// place here
					}.padding()
				}
			}
			
		}
	}
}

struct CheckoutView_Preview: PreviewProvider {

	static var previews: some View {
		CheckoutView(order: Order())
	}
}
