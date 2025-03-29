//
//  testApp.swift
//  test
//
//  Created by Octavio Lara on 26/03/2025.
//

import SwiftUI
import SwiftData
@main
struct testApp: App {
    // declarative container
    let container: ModelContainer = {
        let schema = Schema([Expense.self])
        let config = ModelConfiguration()
        let container = try! ModelContainer(for: schema, configurations: config)
        return container
    }()
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(container)
        // TO store several values you'd use:
        // .modelContainer(for: [...])
//        .modelContainer(for: Expense.self)
    }
}
