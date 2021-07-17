//
//  Arrrow.swift
//  Drawing
//
//  Created by Pogos Anesyan on 10.07.2021.
//

import SwiftUI

struct Arrow {

	var triangleHeight: CGFloat
	var triangleWidth: CGFloat
	
	var squareHeight: CGFloat
	var squareWidth: CGFloat

	var offsetFromTop: CGFloat
}

// MARK: - InsettableShape

extension Arrow: InsettableShape {

	func path(in rect: CGRect) -> Path {
		var arrow = Path()
	
		let triangle = createTriangle(rect: rect)
		let square = createSquare(rect: rect)

		arrow.addPath(triangle)
		arrow.addPath(square)

		return arrow
	}

	func inset(by amount: CGFloat) -> some InsettableShape {
		self
	}
}

// MARK: - Private Methods

private extension Arrow {

	func createTriangle(rect: CGRect) -> Path {
		var triangle = Path()

		let startPoint = CGPoint(x: rect.midX, y: offsetFromTop)

		triangle.move(to: startPoint)
		
		triangle.addLine(to: CGPoint(x: rect.midX - triangleWidth / 2,
									 y: triangleHeight + offsetFromTop))

		triangle.addLine(to: CGPoint(x: rect.midX - squareWidth / 2,
									 y: triangleHeight + offsetFromTop))

		triangle.move(to: CGPoint(x: rect.midX + squareWidth / 2,
								  y: triangleHeight + offsetFromTop))

		triangle.addLine(to: CGPoint(x: rect.midX + triangleWidth / 2,
									 y: triangleHeight + offsetFromTop))

		triangle.addLine(to: startPoint)

		return triangle
	}

	func createSquare(rect: CGRect) -> Path {

		var square = Path()
		square.move(to: CGPoint(x: rect.midX + squareWidth / 2,
								y: triangleHeight + offsetFromTop))
		square.addLine(to: CGPoint(x: rect.midX + squareWidth / 2,
								   y: triangleHeight + offsetFromTop + squareHeight))
		square.addLine(to: CGPoint(x: rect.midX - squareWidth / 2,
								   y: triangleHeight + offsetFromTop + squareHeight))
		square.addLine(to: CGPoint(x: rect.midX - squareWidth / 2,
								   y: triangleHeight + offsetFromTop))

		return square
	}
}
