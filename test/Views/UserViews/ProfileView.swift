//
//  ProfileView.swift
//  test
//
//  Created by Octavio Lara on 07/04/2025.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var auth: AuthManager
    var body: some View {
        if auth.user == nil {
            Text("Unauthenticated")
        } else {
            VStack {
                Text(auth.user?.name ?? "")
                    .font(.headline)
                Button("Logout"){
                    auth.logout()
                }
            }
        
        }
        
    }
}

#Preview {
    ProfileView()
        .environmentObject(AuthManager())
}
