//
//  Arc.swift
//  Drawing
//
//  Created by Pogos Anesyan on 08.06.2021.
//

import SwiftUI

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
