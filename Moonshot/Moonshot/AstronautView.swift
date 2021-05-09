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

					Spacer(minLength: 20)

					HStack {
						Text("Missions")
							.font(.largeTitle)
						Spacer()
						
					}.padding(.horizontal)
					
					ForEach(Constants.missions) { mission in
						ForEach(mission.crew, id: \.name) { astro in
							if astro.name == astronaut.id {
								HStack {
									Image(mission.image)
										.resizable()
										.scaledToFit()
										.frame(width: 44, height: 44)
									Text(mission.displayName)
									Spacer()
								}
								.padding()
								Divider()
									.frame(width: UIScreen.main.bounds.width - 50,
										   height: 1,
										   alignment: .center)
							}
						}
					}
				}
			}
		}
		.navigationBarTitle(Text(astronaut.name), displayMode: .inline)
	}
}

struct AstronautView_Previews: PreviewProvider {

	static var previews: some View {
		AstronautView(astronaut: Constants.astronauts[0])
	}
}
