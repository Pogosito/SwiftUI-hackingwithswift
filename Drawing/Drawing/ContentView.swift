//
//  ContentView.swift
//  Drawing
//
//  Created by Pogos Anesyan on 04.06.2021.
//

import SwiftUI

struct Triangle: Shape {

	func path(in rect: CGRect) -> Path {
		var path = Path()
		path.move(to: CGPoint(x: rect.midX, y: rect.minY))
		path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
		path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
		path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))

		return path
	}
}

struct Arc: InsettableShape {

	var startAngle: Angle
	var endAngle: Angle
	var clockwise: Bool
	var insetAmount: CGFloat = 0

	func path(in rect: CGRect) -> Path {
		var path = Path()
		path.addArc(center: CGPoint(x: rect.midX, y: rect.midY),
					radius: rect.width / 2 - insetAmount,
					startAngle: startAngle,
					endAngle: endAngle,
					clockwise: !clockwise)
		return path
	}

	func inset(by amount: CGFloat) -> some InsettableShape {
		var arc = self
		arc.insetAmount += amount
		return arc
	}
}

struct ContentView: View {

	private var screenWidth = UIScreen.main.bounds.width
	private var screenHeight = UIScreen.main.bounds.height

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

			}.frame(width: 300, height: 150)
	
			Arc(startAngle: Angle(degrees: 0),
				endAngle: Angle(degrees: 180),
				clockwise: false)
				.strokeBorder(Color.blue, lineWidth: 20)
				.frame(width: 100, height: 100)

			Circle()
				.strokeBorder(Color.blue,
						lineWidth: 40)
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
