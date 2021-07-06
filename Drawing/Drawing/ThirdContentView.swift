//
//  ThirdContentView.swift
//  Drawing
//
//  Created by Pogos Anesyan on 23.06.2021.
//

import SwiftUI

struct ThirdContentView: View {

	@State private var insetAmount: CGFloat = 50
	@State private var insetFromCenter: CGFloat = 30
	@State private var sideLength: CGFloat = 10
	@State private var rotation: CGFloat = 10

	var body: some View {
		VStack {
			ZStack {
				Star(insetFromCenter: insetFromCenter,
						sideLength: sideLength)
					.fill(Color.blue, style: FillStyle(eoFill: true))
					.frame(width: 100, height: 100, alignment: .center)
			}
			.frame(width: 100,
					height: 100)
		}
		.onTapGesture {
			withAnimation {
				self.insetFromCenter = CGFloat.random(in: 20...100)
				self.sideLength = CGFloat.random(in: 20...100)
				self.rotation = CGFloat.random(in: 20...100)
			}
		}
	}
}

struct ThirdContentView_Preview: PreviewProvider {
	static var previews: some View {
		ThirdContentView()
	}
}

