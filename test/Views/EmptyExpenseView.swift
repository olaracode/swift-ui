//
//  EmptyExpenseView.swift
//  test
//
//  Created by Octavio Lara on 29/03/2025.
//

import SwiftUI

struct EmptyExpenseView: View {
    let openExpenseSheet: () -> Void
    var body: some View {
        ContentUnavailableView(label: {
            Label("No Expenses", systemImage: "list.bullet.rectangle.portrait")
        }, description: {
            Text("Start adding expenses to see your list")
        }, actions: {
            Button("Add Expense") {
                openExpenseSheet()
            }
        })
        .offset(y: -60)
    }
}

#Preview {
    EmptyExpenseView(openExpenseSheet: {})
}
