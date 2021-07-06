//
//  Star.swift
//  Drawing
//
//  Created by Pogos Anesyan on 23.06.2021.
//

import SwiftUI

struct Star: Shape {

	var insetFromCenter: CGFloat = 30
	var sideLength: CGFloat = 20

	// Если надо анимировать больше двух свойств, то используйте в качестве типа второго параметра снова AnimatablePair
	// Пример: AnimatablePair<CGFloat, AnimatablePair<CGFloat, AnimatablePair...>>
	var animatableData: AnimatablePair<CGFloat, CGFloat> {
		get { AnimatablePair(insetFromCenter, sideLength) }
		set {
			insetFromCenter = newValue.first
			sideLength = newValue.second
		}
	}

	func path(in rect: CGRect) -> Path {
		var bigStar = Path()

		for number in stride(from: 0, to: CGFloat.pi * 2, by: CGFloat.pi / 10) {
			let rotation = CGAffineTransform(rotationAngle: number)
			let position = rotation.concatenating(CGAffineTransform(translationX: rect.width / 2,
																	y: rect.height / 2))
			let star = createStar(in: rect)
			let rotatedStar = star.applying(position)

			bigStar.addPath(rotatedStar)
		}
		return bigStar
	}

	func createStar(in rect: CGRect) -> Path {
		var star = Path()
		let h = (sideLength * sqrt(3)) / 2

		let startPoint: (x: CGFloat,
						 y: CGFloat) = (rect.midX, rect.midY - h)

		star.move(to: CGPoint(x: startPoint.x,
							  y: startPoint.y - insetFromCenter))

		star.addLine(to: CGPoint(x: startPoint.x - sideLength / 2,
								 y: startPoint.y + h - insetFromCenter))

		star.addLine(to: CGPoint(x: rect.midX + sideLength / 2,
								 y: rect.midY - insetFromCenter))

		star.addLine(to: CGPoint(x: startPoint.x,
								 y: startPoint.y - insetFromCenter))
		return star
	}
}
