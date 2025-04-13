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
    @State var isVisible = false
    var body: some View {
            NavigationView{
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        // Plant Image
                        Image("plant-pot") // Replace with your image logic
                            .resizable()
                            .scaledToFill()
                            .matchedGeometryEffect(id: plant.id + "-image", in: namespace)
                            .frame(height: 250)
                            .clipped()
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
                        
                        // Plant Name
                        Text(plant.name)
                            .font(.largeTitle)
                            .bold()
                            .padding(.horizontal)
                            .matchedGeometryEffect(id: "plant-name-\(plant.id)", in: namespace)

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
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.white)
                                .matchedGeometryEffect(id: "background-\(plant.id)", in: namespace)
                                
                        )
                        .cornerRadius(12)
                        .padding(.horizontal)
                    }
                }
                .navigationTitle(plant.name)
                
            }
        
    }
}

#Preview {
    @Previewable @Namespace var previewNamespace
    NavigationView {
        PlantDetailsView(
            plant: PlantModel(
                id: "1234",
                name: "Putica",
                light: "Mucha",
                weatherType: .dry,
                status: .inTreatment,
                location: .indoor,
                lastWatered: "Two hours ago",
                nextWatering: Date.now,
                wateringIntervalHours: 24,
                user: "123123123"
            ),
            namespace: previewNamespace
        )

    }
}
