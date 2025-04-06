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
    @StateObject var authManager = AuthManager()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authManager)
        }

    }
}
