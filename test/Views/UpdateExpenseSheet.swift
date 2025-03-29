//
//  UpdateExpenseSheet.swift
//  test
//
//  Created by Octavio Lara on 29/03/2025.
//

import SwiftUI

struct UpdateExpenseSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var expense: Expense
    var body: some View {
        NavigationStack {
            Form {
                TextField("Expense Name", text: $expense.name)
                DatePicker("Date", selection: $expense.date, displayedComponents: .date)
                TextField("Value", value: $expense.value, format: .currency(code: "ARS"))
            }
            .navigationTitle("Update Expense")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        UpdateExpenseSheet(expense: Expense(name: "Macbook Air", date: Date(), value: 100000))
    }
}
