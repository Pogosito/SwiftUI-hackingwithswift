//
//  Trapzoid.swift
//  Drawing
//
//  Created by Pogos Anesyan on 23.06.2021.
//

import SwiftUI

struct Trapezoid: Shape {
	var insetAmount: CGFloat

	var animatableData: CGFloat {
		get { insetAmount }
		set { self.insetAmount = newValue }
	}

	func path(in rect: CGRect) -> Path {
		var path = Path()

		path.move(to: CGPoint(x: 0, y: rect.maxY))
		path.addLine(to: CGPoint(x: insetAmount, y: rect.minY))
		path.addLine(to: CGPoint(x: rect.maxX - insetAmount, y: rect.minY))
		path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
		path.addLine(to: CGPoint(x: 0, y: rect.maxY))

		return path
   }
}
