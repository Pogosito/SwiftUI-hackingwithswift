//
//  ContentView.swift
//  Moonshot
//
//  Created by Pogos Anesyan on 06.05.2021.
//

import SwiftUI

enum Constants {

	static let astronauts: [Astronauts] = Bundle.main.decode("astronauts.json")
	static let missions: [Mission] = Bundle.main.decode("missions.json")
}

struct ContentView: View {

	@State private var isDateShow = false

	var body: some View {
		NavigationView {
			List(Constants.missions) { mission in
				NavigationLink(destination: MissionView(mission: mission,
														astronauts: Constants.astronauts)) {
					Image(mission.image)
						.resizable()
						.scaledToFit()
						.frame(width: 44, height: 44)

					VStack(alignment: .leading) {
						Text(mission.displayName)
							.font(.headline)

						if !isDateShow {
							Text(mission.formattedLaunchDate)
						} else {
							Text(madeCrewsNamesString(by: mission.crew))
						}
					}
				}
			}
			.navigationBarTitle("Moonshot")
			.navigationBarItems(trailing: Toggle("Display the date", isOn: $isDateShow))
		}
	}

	func madeCrewsNamesString(by crews: [Mission.CrewRole]) -> String {
		var result: [String] = []
		for crew in crews {
			result.append(crew.name)
		}
		return result.joined(separator: " ")
	}
}

struct ContentView_Previews: PreviewProvider {

	static var previews: some View {
		ContentView()
	}
}
