//
//  User.swift
//  CupcakeCorner
//
//  Created by Pogos Anesyan on 27.09.2021.
//

import Foundation

class User: ObservableObject, Codable {

	enum CodingKeys: CodingKey {
		case name
	}

	@Published var name = "Anesyan Pogos"

	required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		name = try container.decode(String.self, forKey: .name)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(name, forKey: .name)
	}
}
