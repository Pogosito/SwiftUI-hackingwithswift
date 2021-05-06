//
//  Demo.swift
//  Moonshot
//
//  Created by Pogos Anesyan on 06.05.2021.
//

import SwiftUI

struct Demo: View {
	var body: some View {
		NavigationView {
			VStack {
				GeometryReader { geometry in
					Image("MJ")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.frame(width: geometry.size.width)
				}.frame(width: 100, height: 100, alignment: .center)
				
				ScrollView(.vertical) {
					VStack {
						ForEach(0..<100) { number in
							Text("\(number) Screen")
						}
					}
					.frame(width: UIScreen.main.bounds.width)
					.background(Color.red)
				}
				
				List(0..<100) { number in
					NavigationLink(
						destination: Text("\(number) Screen"),
						label: {
							Text("\(number) Row")
						}
					)
				}

				NavigationLink(
					destination: Text("Detail label"),
					label: {
						Text("Hello world")
					}
				)
			}
			.navigationBarTitle("SwiftUI")
		}
	}
}

struct Demo_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}

