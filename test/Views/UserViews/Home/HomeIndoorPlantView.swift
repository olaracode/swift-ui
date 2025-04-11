//
//  HomeIndoorPlantView.swift
//  test
//
//  Created by Octavio Lara on 07/04/2025.
//

import SwiftUI

struct HomeIndoorPlantView: View {
    var plant: PlantModel
    let namespace: Namespace.ID
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(alignment: .leading, spacing: 8) {
                ZStack(alignment: .topLeading) {
                    Image("plant-pot") // Replace with actual image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 180)
                        .clipped()
                        .cornerRadius(20)
                        .matchedGeometryEffect(id: plant.id + "-image", in: namespace,  isSource: true)
                    ZStack {
                        HStack {
                            Circle()
                                .frame(width: 12, height: 12)
                                .foregroundColor(plant.status.color)
                            Text(plant.status.label) // or "Need watering"
                                .font(.caption)
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(plant.status.color.opacity(0.3))
                    .clipShape(Capsule())
                    .padding(8)
                    .bold()
                   
                }

                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(plant.name)
                            .font(.headline)
                        if let lastWatered = plant.lastWatered {
                            Text("• \(lastWatered)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        } else {
                            Text("• Never watered")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                       
                    }

                    HStack(spacing: 12) {
                        Label(plant.location.label, systemImage: plant.location.icon)
                            .foregroundColor(plant.location.color)
                        Label(plant.weatherType.label, systemImage: plant.weatherType.icon)
                            .foregroundColor(plant.weatherType.color)
                        Label("Light low", systemImage: "sun.min")
                    }
                    .font(.caption)
                    .foregroundColor(.gray)
                }
                .padding([.horizontal, .bottom])
            }
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white)
                    .matchedGeometryEffect(id: plant.id + "-background", in: namespace, isSource: true)
            )
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)

            Image(systemName: "drop.fill")
                .foregroundColor(.blue)
                .padding()
        }
        .padding(.horizontal)
    }

  
}

#Preview {
    @Previewable @Namespace var previewNamespace
    HomeIndoorPlantView(plant: PlantModel(
        id: "1234",
        name: "Putica",
        light: "Mucha",
        weatherType: .dry,
        status: .inTreatment,
        location: .indoor,
        lastWatered: "Two hours ago",
        user: "123123123"
    ),
    namespace: previewNamespace
    )
}
