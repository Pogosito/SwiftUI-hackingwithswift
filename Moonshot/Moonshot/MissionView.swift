//
//  MissionView.swift
//  Moonshot
//
//  Created by Pogos Anesyan on 09.05.2021.
//

import SwiftUI

struct MissionView: View {

	struct CrewMember {
		let role: String
		let astronaut: Astronauts
	}

	let astronauts: [CrewMember]

	let mission: Mission

	init(mission: Mission, astronauts: [Astronauts]) {
		self.mission = mission

		var matches = [CrewMember]()

		for member in mission.crew {
			if let match = astronauts.first(where: { $0.id == member.name }) {
				matches.append(CrewMember(role: member.role, astronaut: match))
			} else {
				fatalError("Missing \(member)")
			}
		}

		self.astronauts = matches
	}

	var body: some View {
		GeometryReader { geometry in
			ScrollView(.vertical) {
				VStack {
					Image(mission.image)
						.resizable()
						.scaledToFit()
						.frame(minWidth: geometry.size.width * 0.7)
						.padding(.top)

					Text(mission.formattedLaunchDate)
						.font(.footnote)

					Text(self.mission.description)
						.padding()

					Spacer(minLength: 25)

					ForEach(astronauts, id: \.role) { crewMember in
						NavigationLink(destination: AstronautView(astronaut: crewMember.astronaut)) {
							HStack {
								Image(crewMember.astronaut.id)
									.resizable()
									.frame(width: 83, height: 60)
									.clipShape(Capsule())
									.overlay(Capsule().stroke(Color.primary, lineWidth: 1))

								VStack(alignment: .leading) {
									Text(crewMember.astronaut.id)
										.font(.headline)
									Text(crewMember.role)
										.foregroundColor(.secondary)
								}
								Spacer()
							}
						}
						.buttonStyle(PlainButtonStyle())
					}
					.padding(.horizontal)
				}
			}
		}
		.navigationBarTitle(Text(mission.displayName), displayMode: .inline)
	}
}

struct MissionView_Previews: PreviewProvider {

	static var previews: some View {
		MissionView(mission: Constants.missions[0], astronauts: Constants.astronauts)
	}
}
