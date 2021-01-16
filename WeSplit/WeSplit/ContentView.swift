//
//  ContentView.swift
//  WeSplit
//
//  Created by Pogos Anesyan on 11.01.2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = ""
    @State private var numberOfPeople = 2
    @State private var tip = ""
   
    var totalPerPerson: Double {
        let peopleCount = Double(2 + numberOfPeople)
        let safeTip = Double(tip) ?? 0
        let orderAmount = Double(checkAmount) ?? 0
        let tipValue = orderAmount / 100 * safeTip
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
    }
    
    var totalAmountWithTip: Double {
        if let safeOrderAmount = Double(checkAmount), let safeTip = Double(tip) {
            return safeOrderAmount + safeOrderAmount / 100 * safeTip
        }
        return 0
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    Picker("Number of people ", selection: $numberOfPeople) {
                        ForEach(2 ..< 100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section(header: Text("How much tip do you want to leave? ")) {
                    TextField("Tip", text: $tip)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("Amount per person"), content: {
                    Text("$ \(self.totalPerPerson, specifier: "%.2f")")
                })
                
                Section(header: Text("Total amount with tips")) {
                    Text("$ \(self.totalAmountWithTip, specifier: "%.2f")")
                }
            }
            .navigationBarTitle(Text("WeSplit"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
