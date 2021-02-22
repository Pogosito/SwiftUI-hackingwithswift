//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Pogos Anesyan on 09.02.2021.
//

import SwiftUI


struct MyModifierForText: ViewModifier {

    func body(content: Content) -> some View {

        ZStack(alignment: .bottomTrailing) {
            Color.green
            content
                .frame(width: 100, height: 70)
                .font(.largeTitle)
                .foregroundColor(Color.red)
                .background(Color.blue)
                .shadow(radius: 15)
                .clipShape(Capsule())
        }
    }
}

extension View {

    func myModifier() -> some View {

        self.modifier(MyModifierForText())
    }
}

struct CapsuleButton: View {

    var action: () -> ()
    var title: String

    var body: some View {
        Button(title, action: action)
            .foregroundColor(Color.blue)
            .frame(width: 200, height: 200, alignment: .center)
            .background(Color.red)
            .clipShape(Capsule())
            .shadow(radius: 10)
    }
}

struct ContentView: View {

    @State private var bool = true
    var someStr = "sdsd"
    
    var someAntoherView = Text("vla")
        .foregroundColor(Color.red)
    var someView: some View {
        Text(someStr)
    }
    
    lazy var anotherView = Text(someStr)

    let someTuple = ("sd", 3, "sd", 3, "sd", 3, "sd", 3, "sd", 3, "sd", 3, "sd", 3, "sd", 3, "sd", 3, "sd", 3, "sd", 3, "sd", 3, "sd", 3, "sd", 3)
    
    var body: some View {
        VStack(spacing: 10) {
            someView
                .makeLargeTitleModifier()
            someView
                .myModifier()
            someAntoherView
                .modifier(MyModifierForText())
            VStack(spacing: 20) {
                Text("Some Text For Text")
                Text("Some Text For Text")
                Text("Some Text For Text")
                    .blur(radius: 0)
                Text("Some Text For Text")
                    .font(.caption2)
                Text("Some Text For Text")
                    .font(.body)
            }
            .font(.headline)
            .blur(radius: 5)
            
            HStack {
                CapsuleButton(action: {
                    print("")
                }, title: "Btn1")
                CapsuleButton(action: {
                    print("")
                }, title: "Btn2")
            }
            
//            GridStask(rows: 3, columns: 3) { row, col in
//                Text("R\(row) C\(col)")
//                Text("R\(row) C\(col)")
//            }
//
            CustomStack() {
                Text("asdsad")
                Text("asdsad")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {

    static var previews: some View {
        ContentView()
    }
}
