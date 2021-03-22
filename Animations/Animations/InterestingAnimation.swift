//
//  InterestingAnimation.swift
//  Animations
//
//  Created by Pogos Anesyan on 21.03.2021.
//

import SwiftUI

// Интересная и довольно простая анимация
struct InterestingAnimation: View {

    let letters = Array("Pogos Anesyan")
    @State private var enabled = false
    @State private var dragAmount = CGSize.zero

    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<letters.count) { num in
                Text(String(self.letters[num]))
                    .padding(5)
                    .font(.title)
                    .background(self.enabled ? Color.blue : Color.red)
                    .offset(self.dragAmount)
                    .animation(Animation.default.delay(Double(num) / 20))
            }
        }
        .gesture(
            DragGesture()
                .onChanged { self.dragAmount = $0.translation }
                .onEnded { _ in
                    self.dragAmount = .zero
                    self.enabled.toggle()
                }
            )
    }
}
