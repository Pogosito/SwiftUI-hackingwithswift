//
//  CustomBinding.swift
//  Milestone_1
//
//  Created by Pogos Anesyan on 27.02.2021.
//

import SwiftUI

struct CustomBinding: View {

    @State var first = false
    @State var second = false
    @State var third = false

    var body: some View {
        let binding = Binding(
            get: { self.first && self.second && self.third},
            set: {
                self.first = $0
                self.second = $0
                self.third = $0
            }
        )
        return Form {
            Section {
                Toggle("first:", isOn: $first)
                Toggle("second:", isOn: $second)
                Toggle("third:", isOn: $third)
            }
            
            Toggle("all:", isOn: binding)
        }
    }
}
