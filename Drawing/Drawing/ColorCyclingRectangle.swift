//
//  ColorCyclingRectangle.swift
//  Drawing
//
//  Created by Pogos Anesyan on 17.07.2021.
//

import SwiftUI

struct ColorCyclingRectangle {

	var amount = 0.0
	var steps = 100
}

// MARK: - View

extension ColorCyclingRectangle: View {

	var body: some View {
		ZStack {
			ForEach(0..<100) { value in
				Rectangle()
					.inset(by: CGFloat(value))
					.strokeBorder(color(for: value, brightness: 1), lineWidth: 2)
			}
		}
	}
}

// MARK: - Helper methods

private extension ColorCyclingRectangle {

	func color(for value: Int, brightness: Double) -> Color {
		var targetHue = Double(value) / Double(steps) + amount

		if targetHue > 1  {
			targetHue -= 1
		}

		return Color(hue: targetHue, saturation: 1, brightness: brightness)
	}
}
