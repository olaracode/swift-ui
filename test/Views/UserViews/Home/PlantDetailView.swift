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
                
                ScrollView {
                            VStack(alignment: .leading, spacing: 24) {
                                // Title
                                Text(plant.name)
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .padding(.bottom, 8)

                                // Info Card
                                VStack(spacing: 16) {
                                    InfoRow(title: "Light level", value: plant.light)
                                    InfoRow(title: "Location", value: plant.location.label)
                                    InfoRow(title: "Weather Type", value: plant.weatherType.label)
                                    InfoRow(title: "Status", value: plant.status.label)

                                    CountdownView(targetDate: plant.nextWatering ?? Date.now)

                                    InfoRow(
                                        title: "Water every...",
                                        value: "\(plant.wateringIntervalHours) hours"
                                    )
                                }
                                .padding()
                                .background(Color(.secondarySystemBackground))
                                .cornerRadius(12)
                            }
                            .padding()
                        }
                .padding()
                
            }
            Spacer()

           
        }
    }
    func formattedDate(_ date: Date) -> String {
           let formatter = DateFormatter()
           formatter.dateStyle = .medium
           formatter.timeStyle = .short
           return formatter.string(from: date)
       }
}
struct InfoRow: View {
    let title: String
    let value: String

    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.gray)
            Spacer()
            Text(value)
                .fontWeight(.medium)
        }
    }
}


#Preview {
    @Previewable @Namespace var previewNamespace
    NavigationView {
        PlantDetailView(
            plant: Placeholders.plant,
            namespace: previewNamespace,
            discard: {}
        )

    }
}
