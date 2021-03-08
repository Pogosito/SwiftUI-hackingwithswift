//
//  ContentView.swift
//  WordScramble
//
//  Created by Pogos Anesyan on 08.03.2021.
//

import SwiftUI

struct ContentView: View {

    let values = ["Array row 1",
                  "Array row 1",
                  "Array row 2",
                  "Array row 1",
                  "Array row 3",
                  "Array row 4"]

    var body: some View {
        List {
            Section(header: Text("Секция 1")) {
                Text("Static row 1")
                Text("Static row 2")
                Text("Static row 3")
            }

            Section(header: Text("Секция 2")) {
                ForEach(0..<3) {
                    Text("Dynamic row \($0)")
                }
            }

            Section(header: Text("Секция 3")) {
                Text("Static row 4")
                Text("Static row 5")
                Text("Static row 6")
            }

            Section(header: Text("Секция 4")) {
                ForEach(values, id: \.self) {
                    Text("\($0)")
                }
            }
        }
        .listStyle(SidebarListStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
