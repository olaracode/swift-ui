//
//  ProtectedView.swift
//  test
//
//  Created by Octavio Lara on 08/04/2025.
//

import SwiftUI

struct ProtectedView<Content: View>: View {
    @EnvironmentObject var auth: AuthManager
    var content: () -> Content
    
    var body: some View {
        if auth.isAuthenticated {
            content()  // Show content if authenticated
        } else {
            Text("Unauthenticated")  // Show unauthenticated message if no user
        }
    }
}
