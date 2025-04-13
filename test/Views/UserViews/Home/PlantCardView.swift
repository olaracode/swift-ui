//
//  HomeIndoorPlantView.swift
//  test
//
//  Created by Octavio Lara on 07/04/2025.
//

import SwiftUI

struct PlantCardView: View {
    var plant: PlantModel
    let namespace: Namespace.ID
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.green.opacity(0.6), .white]),
                startPoint: .top,
                endPoint: .bottom
            )
            .matchedGeometryEffect(id: "plant-\(plant.id)-bg", in: namespace)
            .frame(maxWidth: .infinity)
            .cornerRadius(20)
            
            
            ZStack {
                ZStack(alignment: .topLeading) {
                    Image("plant-pot") // Replace with actual image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .matchedGeometryEffect(id: "plant-\(plant.id)-image", in: namespace,  isSource: true)
                        .frame(maxWidth: .infinity)
                        .clipped()
                        .cornerRadius(20)
                        .overlay(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.clear,
                                    Color.clear,
                                    Color.black.opacity(0.60)
                                ]),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                            .cornerRadius(20)
                        )
                    PlantStatusBadge(status: plant.status)
                    
                }
                VStack(alignment: .trailing){
                    Spacer()
                    HStack(alignment: .center) {
                        Text(plant.name)
                            .matchedGeometryEffect(id: "plant-\(plant.id)-text", in: namespace)
                        
                            .foregroundColor(.white)
                            .font(.title)
                        Text("Watered: \(plant.lastWatered ?? "")")
                            .foregroundColor(.white)
                            .font(.caption)
                        Spacer()
                    }
                    
                }
                .padding()
                
            }
            .padding(2)
        }
        .shadow(radius: 0.8)
    }

  
}

#Preview {
    @Previewable @Namespace var previewNamespace
    PlantCardView(plant: PlantModel(
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
