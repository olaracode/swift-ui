//
//  MainUserView.swift
//  test
//
//  Created by Octavio Lara on 05/04/2025.
//

import SwiftUI

struct MainUserView: View {
    @EnvironmentObject var auth: AuthManager
    @EnvironmentObject var plant: PlantManagerc
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Plants", systemImage: "leaf")
                }
            
            
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
        }
        .task {
            do {
                if auth.token == nil { return }
                try await plant.getPlants(token: auth.token ?? "")
            } catch {
                print("There was an error fetching the plants: \(error)")
            }
        }
    }
    
 
}

#Preview {
    MainUserView()
        .environmentObject(AuthManager())
        .environmentObject(PlantManager())
}
