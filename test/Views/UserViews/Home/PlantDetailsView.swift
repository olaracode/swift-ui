//
//  PlantDetailsView.swift
//  test
//
//  Created by Octavio Lara on 09/04/2025.
//

import SwiftUI

struct PlantDetailsView: View {
    let plant: PlantModel
    let namespace: Namespace.ID
    var body: some View {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    // Plant Image
                    Image("plant-pot") // Replace with your image logic
                        .resizable()
                      
                        .scaledToFill()
                        .frame(height: 250)
                        .clipped()
                        .cornerRadius(20)
                        .overlay(
                            HStack {
                                Spacer()
                                VStack {
                                    PlantStatusBadge(status: plant.status)
                                    Spacer()
                                }
                            }
                            .padding()
                        )
                        .matchedGeometryEffect(id: plant.id + "-image", in: namespace, isSource: false)
                    
                    // Plant Name
                    Text(plant.name)
                        .font(.largeTitle)
                        .bold()
                        .padding(.horizontal)

                    // Last Watered
                    if let last = plant.lastWatered {
                        HStack(spacing: 8) {
                            Image(systemName: "drop.fill")
                                .foregroundColor(.blue)
                            Text("Last watered: \(last)")
                                .font(.subheadline)
                        }
                        .padding(.horizontal)
                    }

                    // Attributes
                    VStack(alignment: .leading, spacing: 8) {
                        AttributeView(label: "Location", value: plant.location.rawValue)
                        AttributeView(label: "Light", value: plant.light)
                        AttributeView(label: "Weather", value: plant.weatherType.rawValue)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    .padding(.horizontal)
                }
            }
            .background(Color.white.ignoresSafeArea())
        
    }
}

#Preview {
    @Previewable @Namespace var previewNamespace
    NavigationView {
        PlantDetailsView(
            plant: PlantModel(
                id: "123123",
                name: "Plant",
                light: "High",
                weatherType: .humid,
                status: .healthy,
                location: .indoor,
                lastWatered: "2 hours ago",
                user: "asdfasdf"
            
            ),
            namespace: previewNamespace
        )

    }
}
