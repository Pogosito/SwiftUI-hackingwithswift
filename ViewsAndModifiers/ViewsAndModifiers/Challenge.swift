//
//  Challenge.swift
//  ViewsAndModifiers
//
//  Created by Pogos Anesyan on 22.02.2021.
//

import SwiftUI

struct LargeTitleModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .frame(width: 200, height: 150, alignment: .center)
            .font(.system(.largeTitle, design: .rounded))
            .foregroundColor(.white)
            .background(Color.blue)
            .clipShape(Capsule())
    }
}

extension View {

    func makeLargeTitleModifier() -> some View {
        self.modifier(LargeTitleModifier())
    }
}
