//
//  Demo.swift
//  Animations
//
//  Created by Pogos Anesyan on 17.03.2021.
//

import SwiftUI

struct Demo: View {

    @State private var animationAmount: CGFloat = 1
    @State private var secondAnimationAmount: CGFloat = 1
    @State private var thirdAnimationAmount = 0.0
    @State private var isOn = false
    @State private var dragAmount = CGSize.zero

    var body: some View {
        VStack {
            Group {
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
            }
            Spacer()

            Button("Tap me") {
                isOn.toggle()
            }
            .frame(width: 100, height: 100)
            .foregroundColor(.white)
            .background(isOn ? Color.red : Color.orange)
            .animation(.easeIn)
            .clipShape(RoundedRectangle(cornerRadius: isOn ? 50 : 0))
            .animation(.default)

            Spacer()

            LinearGradient(gradient: Gradient(colors: [.yellow, .red]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .frame(width: 100, height: 100, alignment: .center)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .offset(dragAmount)
                .gesture(
                    DragGesture()
                        .onChanged { currentPoint in
                            self.dragAmount = currentPoint.translation }
                        .onEnded { _ in
                            withAnimation(.spring()) {
                                self.dragAmount = .zero
                            }
                        }
                )
            Spacer()
        }
    }
}
