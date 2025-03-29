//
//  ContentView.swift
//  test
//
//  Created by Octavio Lara on 26/03/2025.
//

import SwiftUI
import SwiftData
struct ContentView: View {
    @Environment(\.modelContext) var context
    @State private var isShowingItemSheet = false
    @State private var expenseToEdit: Expense?
    
    @Query(sort: \Expense.date) var expenses: [Expense]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(expenses) { expense in
                    ExpenseCell(expense: expense)
                        .onTapGesture {
                            expenseToEdit = expense
                        }
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        context.delete(expenses[index])
                    }
                }
            }
            .navigationTitle("Expenses")
            .navigationBarTitleDisplayMode(.large)
            .sheet(isPresented: $isShowingItemSheet) {
                AddExpenseSheet()
            }
            .sheet(item: $expenseToEdit) { expense in
                UpdateExpenseSheet(expense: expense)
            }
            .toolbar {
                if !expenses.isEmpty {
                    Button("Add Expense", systemImage: "plus") {
                        isShowingItemSheet = true
                    }
                }
            }
            .overlay {
                if expenses.isEmpty {
                    ContentUnavailableView(label: {
                        Label("No Expenses", systemImage: "list.bullet.rectangle.portrait")
                    }, description: {
                        Text("Start adding expenses to see your list")
                    }, actions: {
                        Button("Add Expense") {
                            isShowingItemSheet = true
                        }
                    })
                    .offset(y: -60)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
