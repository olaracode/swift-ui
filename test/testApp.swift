//
//  testApp.swift
//  test
//
//  Created by Octavio Lara on 26/03/2025.
//

import SwiftUI

@main
struct testApp: App {
    @StateObject var listViewModel: ListViewModel = ListViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ListView()
            }
            .environmentObject(listViewModel)
        }
    }
}
