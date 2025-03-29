//
//  AddExpenseSheet.swift
//  test
//
//  Created by Octavio Lara on 28/03/2025.
//

import SwiftUI

struct AddExpenseSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    @State private var name: String = ""
    @State private var date: Date = .now
    @State private var value: Double = 0
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Expense Name", text: $name)
                DatePicker("Date", selection: $date, displayedComponents: .date)
                // For Some reason working with USD didn't work
                TextField("Value", value: $value, format: .currency(code: "ARS"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add Expense")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading){
                    Button("Cancel") { dismiss() }
                }
                ToolbarItemGroup(placement: .topBarTrailing){
                    Button("Save") {
                        let expense = Expense(name: name, date: date, value: value)
                        // this will save automatically
                        context.insert(expense)
                        
                        // to force a save
                        // try! context.save()
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    AddExpenseSheet()
}
