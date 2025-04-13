//
//  PlantDetailsView.swift
//  test
//
//  Created by Octavio Lara on 09/04/2025.
//

import SwiftUI

struct PlantDetailView: View {
    let plant: PlantModel
    let namespace: Namespace.ID
    let discard: () -> Void
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.green.opacity(0.2), .white]),
                startPoint: .top,
                endPoint: .bottom
            )
            .matchedGeometryEffect(id: "plant-\(plant.id)-bg", in: namespace)
            .ignoresSafeArea()
               
            VStack(alignment: .leading) {
                ZStack(alignment: .topLeading) {
                    Image("plant-pot") // Replace with actual image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .matchedGeometryEffect(id: "plant-\(plant.id)-image", in: namespace,  isSource: true)
                        .frame(height: 240)
                        .frame(maxWidth: .infinity)
                        .clipped()
                        .cornerRadius(0)
                        .ignoresSafeArea()
                    Button("Back") {
                        withAnimation {
                            discard()
                        }
                    }
                    .padding()
               
                }
                
                VStack {
                    Text("Hey")
                        .matchedGeometryEffect(id: "plant-\(plant.id)-text", in: namespace)
                        .foregroundColor(.black)
                        .font(.title)
                    Spacer()
                }
                .padding()
                
            }

           
        }
    }
}

#Preview {
    @Previewable @Namespace var previewNamespace
    NavigationView {
        PlantDetailView(
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
            namespace: previewNamespace,
            discard: {}
        )

    }
}
