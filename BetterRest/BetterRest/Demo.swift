//
//  Demo.swift
//  BetterRest
//
//  Created by Pogos Anesyan on 06.03.2021.
//

import SwiftUI

struct Demo: View {

    @State private var stepperCounter: UInt8 = 17
    @State private var date = Date()
    var body: some View {
        Form {
            Stepper(value: $stepperCounter) {
                Text("Your value is \(stepperCounter)")
            }

            Stepper(value: $stepperCounter, in: 5...15) {
                Text("Your value is \(stepperCounter)")
            }

            Stepper(value: $stepperCounter, in: 1...30, step: UInt8.Stride(10) ){
                Text("Your value is \(stepperCounter)")
            }

            Section {
                DatePicker("Date", selection: $date)
            }
        }
    }
}
