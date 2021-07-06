//
//  ContentView.swift
//  Drawing
//
//  Created by Pogos Anesyan on 04.06.2021.
//

import SwiftUI

struct ContentView: View {

	private var screenWidth = UIScreen.main.bounds.width
	private var screenHeight = UIScreen.main.bounds.height
	@State private var petalOffset: CGFloat = -20.0
	@State private var petalWidth: CGFloat = 100.0

	var body: some View {
		VStack {
			HStack {
				Path { path in
					path.move(to: CGPoint(x: screenWidth / 3, y: 0))
					path.addLine(to: CGPoint(x: screenWidth / 3 - 50, y: 100))
					path.addLine(to: CGPoint(x: screenWidth / 3 + 50, y: 100))
					path.addLine(to: CGPoint(x: screenWidth / 3, y: 0))
				}
				.stroke(style: StrokeStyle(lineWidth: 2,
										   lineCap: .round,
										   lineJoin: .round,
										   miterLimit: 0,
										   dash: [12, 10, 2],
										   dashPhase: 10))
				.foregroundColor(Color.red)

				Triangle()
					.frame(width: 100,
						   height: 100)
	
				Arc(startAngle: Angle(degrees: 0),
					endAngle: Angle(degrees: 180),
					clockwise: false)
					.strokeBorder(Color.blue, lineWidth: 20)
					.frame(width: 100, height: 100)

				Circle()
					.strokeBorder(Color.blue,
								  lineWidth: 40)
			}.frame(width: 300, height: 150)

			Spacer()
			
			VStack {
				Spacer()

				Flower(petalOffset: petalOffset, petalWidth: petalWidth)
					.fill(Color.red, style: FillStyle(eoFill: true))
					.frame(width: 100,
						   height: 100)
				

				Spacer()
				Spacer()

				Text("Offset")
				Slider(value: $petalOffset, in: -40...40)
					.padding([.horizontal, .bottom])

				Text("Width")
					.frame(width: 50, height: 50)
					.background(Image("image").resizable())
				Slider(value: $petalWidth, in: 0...100)
					.padding([.horizontal])
				
				Group {
					Spacer()
					Spacer()

					Text("Some Text")
						.frame(width: 100, height: 50)
						.border(ImagePaint(image: Image("image"), scale: 0.5), width: 10)

				}
			}
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
