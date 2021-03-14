//
//  ContentView.swift
//  Animations
//
//  Created by Pogos Anesyan on 14.03.2021.
//

import SwiftUI

struct ContentView: View {

    @State private var animationAmount: CGFloat = 1
    @State private var secondAnimationAmount: CGFloat = 1
    @State private var thirdAnimationAmount = 0.0

    var body: some View {
        VStack {
            Stepper("Scale amount", value: $secondAnimationAmount.animation(), in: 0...10)

            Spacer()

            Button("Tap me") {
                secondAnimationAmount += 1
            }
            .padding(50)
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(Circle())
            .scaleEffect(secondAnimationAmount)

            Spacer()

            Button("Tap me") {
            }
            .padding(50)
            .background(Color.green)
            .foregroundColor(.white)
            .clipShape(Circle())
            .overlay(
                Circle()
                    // Пульсирующая анимация обода кнопки
                    .stroke(Color.red)
                    .scaleEffect(animationAmount)
                    .opacity(Double(2 - animationAmount))
                    .animation(
                        Animation.easeInOut(duration: 1)
                            .repeatForever(autoreverses: false)
                    )
            )
            .onAppear(perform: {
                animationAmount = 2
            })

            Spacer()

            Button("Tap me") {
                withAnimation {
                    thirdAnimationAmount += 360
                }
            }
            .padding(50)
            .background(Color.purple)
            .foregroundColor(.white)
            .clipShape(Circle())
            .rotation3DEffect(
                .degrees(thirdAnimationAmount),
                axis: (x: 0, y: 1, z: 0)
            )

            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
