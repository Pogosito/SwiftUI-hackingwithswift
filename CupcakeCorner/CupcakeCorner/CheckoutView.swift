//
//  CheckoutView.swift
//  CheckoutView
//
//  Created by Pogos Anesyan on 02.10.2021.
//

import SwiftUI

struct CheckoutView: View {

	@ObservedObject var order: Order
	@State private var confirmationMessage = ""
	@State private var showingResponseInformation = false
	@State private var isError = false
	@State private var error: LocalizedError?

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
						placeOrder()
					}.padding()
				}
			}
		}
		.alert(isPresented: $showingResponseInformation) {
			Alert(title: Text(isError ? "OOPS!" : "Thank you"),
				  message: Text(isError ? self.error?.localizedDescription ?? "Some unknown error" : confirmationMessage),
				  dismissButton: .default(Text(isError ? "Try later" : "OK"))
			)
		}
	}

	func placeOrder() {
		guard let encoded = try? JSONEncoder().encode(order) else {
			print("Failed to encode order")
			return
		}
		let url = URL(string: "https://reqres.in/api/cupcakes")!
		var request = URLRequest(url: url)
		request.setValue("application/json", forHTTPHeaderField: "Content-Type")
		request.httpMethod = "POST"
		request.httpBody = encoded

		URLSession.shared.dataTask(with: request) { data, response, error in
			guard let safeData = data else {
				print("No data in response: \(error?.localizedDescription ?? "Unknown error")")
				isError = true
				showingResponseInformation = true
				return
			}

			if let decoderOrder = try? JSONDecoder().decode(Order.self, from: safeData) {
				confirmationMessage = "Your order for \(decoderOrder.orderValues.quantity) X \(Order.types[decoderOrder.orderValues.type].lowercased()) cupcakes is on its away"
				isError = false
				showingResponseInformation = true
			} else {
				print("Invalid response from server")
			}
		}.resume()
	}
}

struct CheckoutView_Preview: PreviewProvider {

	static var previews: some View {
		CheckoutView(order: Order())
	}
}
