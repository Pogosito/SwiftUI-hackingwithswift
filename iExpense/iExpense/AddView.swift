//
//  AddView.swift
//  iExpense
//
//  Created by Pogos Anesyan on 05.05.2021.
//

import SwiftUI

struct AddView: View {

	@Environment(\.presentationMode) var presentationMode

	@ObservedObject var expense: Expenses

	@State private var name = ""
	@State private var type = "Personal"
	@State private var amount = ""
	@State private var isAlertPresent = false

	static let types = ["Business", "Personal"]

	var body: some View {
		NavigationView {
			Form {
				TextField("Name", text: $name)
				Picker("Type",
					   selection: $type) {
					ForEach(Self.types, id: \.self) {
						Text($0)
					}
				}
				TextField("Amount", text: $amount)
					.keyboardType(.numberPad)
			}
			.navigationBarTitle("Add new expense")
			.navigationBarItems(trailing: Button("Save", action: {
				if let safeIntAmount = Int(self.amount) {
					let item = ExpenseItem(name: self.name,
										   type: self.type,
										   amount: safeIntAmount)
					expense.items.append(item)
					presentationMode.wrappedValue.dismiss()
				} else {
					isAlertPresent = true
				}
			}))
			.alert(isPresented: $isAlertPresent, content: {
				Alert(title: Text("Error"),
					  message: Text("You can't enter in the amount section other than numbers"),
					  dismissButton: .default(Text("Repeat")))
			})
		}
	}
}

struct AddView_Previews: PreviewProvider {
	static var previews: some View {
		AddView(expense: Expenses())
	}
}
