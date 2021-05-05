//
//  Demo.swift
//  iExpense
//
//  Created by Pogos Anesyan on 19.04.2021.
//

import SwiftUI

struct SecondView: View {

	@Environment(\.presentationMode) var presentationMode

	var body: some View {
		ZStack {
			Color.red
			VStack {
				Text("This is a second view")
				Button("Dismiss") {
					presentationMode.wrappedValue.dismiss()
				}
			}
		}
		.ignoresSafeArea()
	}
}

class User: ObservableObject {
	@Published var name = "Pogos"
	@Published var secondName = "Anesyan"
}

struct Demo: View {

	@ObservedObject private var user = User()
	@State private var isSecondViewShow = false

	@State private var numbers: [Int] = [1, 2, 3]
	@State private var currentNumber = 4

	var body: some View {
		VStack {
			Text("User name is \(user.name), \(user.secondName)")
			TextField("New user name", text: $user.name)
			TextField("New user secondName", text: $user.secondName)

			Spacer()

			Button("Open Second View") {
				isSecondViewShow.toggle()
			}.sheet(isPresented: $isSecondViewShow, content: {
				SecondView()
			})

			List {
				ForEach(numbers, id: \.self) {
					Text("\($0)")
				}
				.onDelete(perform: { indexSet in
					numbers.remove(atOffsets: indexSet)
				})
			}

			Button("Add new row") {
				numbers.append(currentNumber)
				currentNumber += 1
			}
		}
	}
}
