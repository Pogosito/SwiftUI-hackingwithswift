//
//  Order.swift
//  CupcakeCorner
//
//  Created by Pogos Anesyan on 02.10.2021.
//

import SwiftUI

struct OrderWrapper: Codable {

	var type = 0
	var quantity = 3

	var specialRequestEnabled = false {
		didSet {
			if specialRequestEnabled == false {
				extraFrosting = false
				addSprinkles = false
			}
		}
	}

	var extraFrosting = false
	var addSprinkles = false

	var name = ""
	var streetAddress = ""
	var city = ""
	var zip = ""
}

class Order: ObservableObject, Codable {

	@Published var orderValues = OrderWrapper(type: 0,
											  quantity: 0,
											  specialRequestEnabled: false,
											  extraFrosting: false,
											  addSprinkles: false,
											  name: "",
											  streetAddress: "",
											  city: "",
											  zip: "")

	var isFieldsEmpty: Bool {
		orderValues.name.isEmpty || orderValues.streetAddress.isEmpty || orderValues.city.isEmpty || orderValues.zip.isEmpty
	}

	var isFieldsWhiteSpace: Bool {
		orderValues.name.hasPrefix(String(repeating: " ", count: orderValues.name.count))
		|| orderValues.streetAddress.hasPrefix(String(repeating: " ", count: orderValues.streetAddress.count))
		|| orderValues.city.hasPrefix(String(repeating: " ", count: orderValues.city.count))
		|| orderValues.zip.hasPrefix(String(repeating: " ", count: orderValues.zip.count))
	}

	var hasValidAddress: Bool {
		if isFieldsEmpty || isFieldsWhiteSpace { return false }
		return true
	}

	var order: Double {
		var cost = Double(orderValues.quantity) * 2

		cost += (Double(orderValues.type) / 2)

		if orderValues.extraFrosting { cost += Double(orderValues.quantity) }
		if orderValues.addSprinkles { cost += Double(orderValues.quantity) / 2 }
		return cost
	}

	static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]

	enum CodingKeys: CodingKey {
		case orderValues
	}

	required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		orderValues = try container.decode(OrderWrapper.self, forKey: .orderValues)
	}

	init() {}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(orderValues, forKey: CodingKeys.orderValues)
	}
}
