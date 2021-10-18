//
//  Validating.swift
//  CupcakeCorner
//
//  Created by Pogos Anesyan on 27.09.2021.
//

import SwiftUI

struct Validating: View {

	@State private var username = ""
	@State private var email = ""

	private var conditionOfRegistration: Bool {
		return username.count < 5 && email.count < 5
	}

	var body: some View {
		Form {
			Section {
				TextField("Username", text: $username)
				TextField("email", text: $email)
			}

			Button("Register") {
				print("You're registered")
			}.disabled(!conditionOfRegistration)
		}
	}
}

struct Validating_Preview: PreviewProvider {

	static var previews: some View {
		Validating()
	}
}
