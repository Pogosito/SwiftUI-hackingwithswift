//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Pogos Anesyan on 29.01.2021.
//

import SwiftUI

struct ContentView: View {

    let linerGradient = LinearGradient(gradient: Gradient(colors: [.blue, .white, .purple]), startPoint: .topLeading, endPoint: .bottomTrailing)

    let radialGradinet = RadialGradient(gradient: Gradient(colors: [.green, .yellow, .blue, .white]), center: .topLeading, startRadius: 50, endRadius: 300)

    let angularGradinet = AngularGradient(gradient: Gradient(colors: [.red, .blue, .green, .purple]), center: .bottom)

    var body: some View {
        VStack(alignment: .trailing, spacing: 20) {
            Text("Hello, world!")
            Text("Pogos krasava")
            Section {
                Text("Text in VStack #1")
                Text("Text in VStack #2")
                Text("Text in VStack #3")
                Text("Text in VStack #4")
                Button("It is a button") {
                    print("Pressed button")
                }
                .frame(width: 100, height: 100, alignment: .center)
                .background(Color.red)
                
                Button(action: {
                    print("Pogos")
                }, label: {
                    ZStack {
                        Color.clear
                        VStack {
                            Image(systemName: "book").renderingMode(.original)
                            Text("Book button with advanced layout ")
                        }
                    }
                })
            }
            Group {
                Text("Text in VStack #6")
                Text("Text in VStack #7")
                Text("Text in VStack #8")
                Text("Text in VStack #9")
                Text("Text in VStack #10")
            }
            HStack(alignment: .center) {
                ZStack {
                    angularGradinet
                    Text("sad")
                }
                Spacer()
                HStack(spacing: 50){
                    Text("Text in HStack #1")
                    Text("Text in HStack #2")
                    Spacer()
                }
                .background(linerGradient)
            }
            .frame(width: 200, height: 200, alignment: .center)
            ZStack(alignment: .top) {
                Color.red
                Text("Text in ZStack #2000")
                Text("Text in ZStack #1")
            }
            Spacer()
        }
        .background(radialGradinet)
        .ignoresSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
