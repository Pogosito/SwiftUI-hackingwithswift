//
//  ContentView.swift
//  Animations
//
//  Created by Pogos Anesyan on 14.03.2021.
//

import SwiftUI

struct ContentView: View {

    @State private var isShown = true

    var body: some View {
        VStack {
            Button("Tap me") {
                withAnimation {
                    isShown.toggle()
                }
            }
            
            if (isShown) {
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 200, height: 200)
                    .transition(.pivot)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
