//
//  ContentView.swift
//  test
//
//  Created by Octavio Lara on 26/03/2025.
//

import SwiftUI
import SwiftData
struct ContentView: View {
    @EnvironmentObject var auth: AuthManager
    var body: some View {
        Group{
            if(!auth.isLoading){
                
            
                if !auth.isAuthenticated {
                    InitialView()
                } else {
                    MainUserView()
                }
            } else {
                Text("...Loading")
            }
        }
        .onAppear {
            Task {
                if let _ = auth.token {
                    auth.load()
                    await auth.fetchUser()
                }
            }
        }
    }
}


#Preview {
    ContentView()
        .environmentObject(AuthManager())
        .environmentObject(PlantManager())
}
