//
//  AstronautView.swift
//  Moonshot
//
//  Created by Pogos Anesyan on 09.05.2021.
//

import SwiftUI

struct AstronautView: View {

	let astronaut: Astronauts

	var body: some View {
		GeometryReader { geometry in
			ScrollView(.vertical) {
				VStack {
					Image(self.astronaut.id)
						.resizable()
						.scaledToFit()
						.frame(width: geometry.size.width)

					Text(self.astronaut.description)
						.padding()
				}
			}
		}
		.navigationBarTitle(Text(astronaut.name), displayMode: .inline)
	}
}

struct AstronautView_Previews: PreviewProvider {

	static let astronauts: [Astronauts] = Bundle.main.decode("astronauts.json")

	static var previews: some View {
		AstronautView(astronaut: astronauts[0])
	}
}
