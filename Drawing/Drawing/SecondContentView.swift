//
//  SecondContentView.swift
//  Drawing
//
//  Created by Pogos Anesyan on 22.06.2021.
//

import SwiftUI

struct SecondContentView: View {

	@State private var amount: CGFloat = 0.0
	var body: some View {
		VStack {
			Image("girl")
				.resizable()
				.scaledToFit()
				.frame(width: 200, height: 200)
				.saturation(Double(amount))
				.blur(radius: (1 - amount) * 20)

			Spacer()

			ZStack {
				Circle()
					.fill(Color.red)
					.frame(width: 200 * amount)
					.offset(x: -50, y: -80)
					.blendMode(.screen)

				Circle()
					.fill(Color.green)
					.frame(width: 200 * amount)
					.offset(x: 50, y: -80)
					.blendMode(.screen)

				Circle()
					.fill(Color.blue)
					.frame(width: 200 * amount)
					.blendMode(.screen)
			}.frame(width: 300, height: 300)

			Slider(value: $amount)
				.padding()
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.background(Color.white)
		.edgesIgnoringSafeArea(.all)
	}
}

struct SecondContentView_Preview: PreviewProvider {
	static var previews: some View {
		SecondContentView()
	}
}
