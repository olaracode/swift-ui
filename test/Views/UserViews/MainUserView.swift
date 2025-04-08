//
//  MainUserView.swift
//  test
//
//  Created by Octavio Lara on 05/04/2025.
//

import SwiftUI

struct MainUserView: View {
    @EnvironmentObject var auth: AuthManager
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
    }
}

#Preview {
    MainUserView()
}
