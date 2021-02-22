//
//  GridStack.swift
//  ViewsAndModifiers
//
//  Created by Pogos Anesyan on 14.02.2021.
//

import SwiftUI

struct GridStask<Content: View>: View {

    var rows: Int
    var columns: Int
    var content: (Int, Int) -> Content
    
    init(rows: Int, columns: Int, @ViewBuilder content: @escaping (Int, Int) -> Content) {
        self.rows = rows
        self.columns = columns
        self.content = content
    }
    
    var body: some View {
        VStack {
            ForEach(0..<rows, id: \.self) { row in
                HStack {
                    ForEach(0..<self.columns, id: \.self) { column in
                        self.content(row, columns)
                    }
                }
            }
        }
    }
}

struct CustomStack<Content: View>: View {

    var content: () -> Content

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    var body: some View {
        HStack {
            content()
        }
    }
}
