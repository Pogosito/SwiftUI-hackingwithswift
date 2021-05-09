//
//  Bundle+Decodable.swift
//  Moonshot
//
//  Created by Pogos Anesyan on 07.05.2021.
//

import Foundation

extension Bundle {

	func decode<T: Codable>(_ file: String) -> T {
		guard let url = self.url(forResource: file, withExtension: nil) else {
			fatalError("Failed to locate \(file) in bundle")
		}

		guard let data = try? Data(contentsOf: url) else {
			fatalError("Failed to locate \(file) from bundle")
		}

		let decoder = JSONDecoder()

		let formatter = DateFormatter()
		formatter.dateFormat = "y-MM-dd"

		decoder.dateDecodingStrategy = .formatted(formatter)

		guard let loaded = try? decoder.decode(T.self,
											   from: data) else {
			fatalError()
		}

		return loaded
	}
}
