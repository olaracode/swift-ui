//
//  ExpenseCell.swift
//  test
//
//  Created by Octavio Lara on 28/03/2025.
//

import SwiftUI

struct ExpenseCell: View {
    let expense: Expense
    var body: some View {
        HStack {
            Text(expense.date, format: .dateTime.month(.abbreviated).day())
                .frame(width: 70, alignment: .leading)
            Text(expense.name)
            Spacer()
            Text(expense.value, format: .currency(code: "usd"))
        }
    }
}

#Preview {
    ExpenseCell(expense: Expense(name: "Ipad", date: .now, value: 20))
}
