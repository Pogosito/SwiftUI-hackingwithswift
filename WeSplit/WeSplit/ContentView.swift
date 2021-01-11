//
//  ContentView.swift
//  WeSplit
//
//  Created by Pogos Anesyan on 11.01.2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countTap = 3
    @State private var someBool = false
    @State private var name = "Pogos"
    
    let options: [String] = ["options 1", "options 2", "options 3", "options 4", "options 5"]
    @State private var selectedOption = 0
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Секции разделяют дочерние элементы визуально"), footer: Text("Ниже элементы разделены на две группы, но при этом никого визуального разделения мы не замечаем")) {
                    Text("Hello, world!")
                    Text("Hello, world!")
                }

                Group {
                    Text("Hello, world!")
                    Text("Hello, world!")
                    Text("Hello, world!")
                    Text("Hello, world!")
                    Text("Hello, world!")
                    Text("Hello, world!")
                }

                Group {
                    Text("Hello, world!")
                    Text("Hello, world!")
                    Text("Hello, world!")
                }

                Section(header: Text("Поскольку отображаемое значение - состояние, то при его изменении обновляется все view, которые отображают это значение")) {
                    Button("Кол - во нажатий \(self.countTap)") {
                        self.countTap += 1
                    }
                }

                Section(header: Text("Two-way binding, сам textField способен изменять значение, записанное в состоянии")) {
                    TextField("", text: $name)
                    Text("My name is \(name)")
                }
                
                Section(header: Text("С помощью ForEach можно легко создать picker")) {
                    Picker(selection: $selectedOption, label: Text("Пикер"), content: {
                        Text("Some Text")
                        Text("Some Text")
                    })
                }
            }
            .navigationBarTitle("SwiftUI", displayMode: .large)
       }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
