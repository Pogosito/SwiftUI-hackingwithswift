//
//  ContentView.swift
//  Moonshot
//
//  Created by Pogos Anesyan on 06.05.2021.
//

import SwiftUI

struct ContentView: View {

	let astronauts: [Astronauts] = Bundle.main.decode("astronauts.json")
	let missions: [Mission] = Bundle.main.decode("missions.json")

	var body: some View {
		NavigationView {
			List(missions) { mission in
				NavigationLink(destination: Text("Detail view")) {
					Image(mission.image)
						.resizable()
						.scaledToFit()
						.frame(width: 44, height: 44)

					VStack(alignment: .leading) {
						Text(mission.displayName)
							.font(.headline)
						Text(mission.formattedLaunchDate)
					}
				}
			}
			.navigationBarTitle("Moonshot")
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
