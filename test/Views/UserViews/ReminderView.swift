//
//  ReminderView.swift
//  test
//
//  Created by Octavio Lara on 19/04/2025.
//

import SwiftUI

struct ReminderView: View {
    @EnvironmentObject var plantManager: PlantManager
    @EnvironmentObject var auth: AuthManager
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
               
                ReminderList(title: "🪴 Plants with notifications", action: {
                    print(":")
                }) {
                    List {
                        if !plantManager.plantsWithNotification.isEmpty {
                            ForEach(plantManager.plantsWithNotification){ plant in
                                HStack {
                                    Text(plant.name)
                                    
                                    Text("Tiene notification")
                                }
                                
                            }
                        } else {
                            Text("You have no plants with notification")
                        }
                    }
                }
            }
         
            .navigationTitle("Notifications")
            
        }
    }
}

struct ReminderList<Content: View>: View {
    let title: String
    let action: (() -> Void)?
    let content: () -> Content
    var body: some View {
        VStack{
            HStack {
                Text(title)
                    .font(.headline)
                Spacer()
//                if let action = action {
//                    Button("Add", action: action)
//                }
            }
            content()
        }
    }
    
}

#Preview {
    ReminderView()
        .environmentObject(PlantManager())
        .environmentObject(AuthManager())
}
