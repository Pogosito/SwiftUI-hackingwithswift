//
//  Mission.swift
//  Moonshot
//
//  Created by Pogos Anesyan on 08.05.2021.
//

import Foundation

struct Mission: Codable, Identifiable {

	var displayName: String {
		"Apollo \(id)"
	}

	var image: String {
		"apollo\(id)"
	}

	var formattedLaunchDate: String {
		if let launchDate = launchDate {
			let formatter = DateFormatter()
			formatter.dateStyle = .long
			return formatter.string(from: launchDate)
		} else {
			return "N/A"
		}
	}

	let id: Int
	let launchDate: Date?

	struct CrewRole: Codable {

		let name: String
		let role: String
	}

	let crew: [CrewRole]
	let description: String
}

