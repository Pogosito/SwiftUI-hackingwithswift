//
//  FourthContentView.swift
//  Drawing
//
//  Created by Pogos Anesyan on 10.07.2021.
//

import SwiftUI

struct FourthContentView: View {

	@State private var arrowLineWidth: CGFloat = 10
	@State private var amount = 0.0

	var body: some View {
		ZStack {
			VStack {
				Arrow(triangleHeight: 100,
					  triangleWidth: 80,
					  squareHeight: 30,
					  squareWidth: 30,
					  offsetFromTop: 20)
					.stroke(Color.green, style: StrokeStyle(lineWidth: arrowLineWidth,
															lineCap: .square,
															lineJoin: .bevel))
					.animation(.spring())
					.onTapGesture {
						arrowLineWidth = CGFloat.random(in: 2..<20)
					}.frame(width: 50,
							height: 50,
							alignment: .center)

				Spacer()
				Spacer()

				ColorCyclingRectangle(amount: amount)
					.frame(width: 200,
						   height: 200,
						   alignment: .center)

				Slider(value: $amount, in: 0.0...1.0)

				Spacer()
			}
			.frame(width: UIScreen.main.bounds.width - 20,
				   height: UIScreen.main.bounds.height,
				   alignment: .center)
		}
		.frame(width: UIScreen.main.bounds.width,
			   height: UIScreen.main.bounds.height)
	}
}

struct FourthContentView_Preview: PreviewProvider {

	static var previews: some View {
		FourthContentView()
	}
}
