//
//  FlagImage.swift
//  GuessTheFlag
//
//  Created by Pogos Anesyan on 23.02.2021.
//

import SwiftUI

struct FlagImage: View {
    
    let image: Image

    init(image: Image) {
        self.image = image
    }

    var body: some View {
        image
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
            .shadow(color: .black, radius: 2)
    }
}
