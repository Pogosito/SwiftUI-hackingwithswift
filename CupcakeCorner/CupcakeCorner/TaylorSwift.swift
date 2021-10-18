//
//  TaylorSwift.swift
//  CupcakeCorner
//
//  Created by Pogos Anesyan on 27.09.2021.
//

import SwiftUI

struct Response: Codable {

	var results: [Result]
}

struct Result: Codable {

	var trackId: Int
	var trackName: String
	var collectionName: String
}

struct TaylorSwift: View {

	@State private var results = [Result]()

	var body: some View {
		List(results, id: \.trackId) { item in
			VStack(alignment: .leading) {
				Text(item.trackName)
					.font(.headline)
				Text(item.collectionName)
			}
		}.onAppear(perform: loadData)
	}

	func loadData() {
		guard let safeURL = URL(
				string: "https://itunes.apple.com/search?term=taylor+swift&entity=song"
		) else {
			print("Invalid url")
			return
		}

		let request = URLRequest(url: safeURL)

		URLSession.shared.dataTask(with: request) { data, response, error in
			if let safeData = data {
				if let decodedData = try? JSONDecoder().decode(Response.self, from: safeData) {
					self.results = decodedData.results
				}
			}
		}.resume()
	}
}

struct TaylorSwift_Previews: PreviewProvider {

	static var previews: some View {
		TaylorSwift()
	}
}
