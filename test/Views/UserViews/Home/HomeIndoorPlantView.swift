//
//  HomeIndoorPlantView.swift
//  test
//
//  Created by Octavio Lara on 07/04/2025.
//

import SwiftUI

struct HomeIndoorPlantView: View {
    var plant: IndoorPlant

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
                    ZStack {
                        HStack {
                            Circle()
                                .frame(width: 12, height: 12)
                                .foregroundColor(.green)
                            Text("Perfectly") // or "Need watering"
                                .font(.caption)
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(Color.appBackground.opacity(0.4))
                    .clipShape(Capsule())
                    .padding(8)
                    .bold()
                   
                }

                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(plant.name)
                            .font(.headline)
                        Text("• \(formattedAge(from: plant.lastWatered)) old")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }

                    HStack(spacing: 12) {
                        Label("Outdoor", systemImage: "leaf")
                        Label("24°C", systemImage: "thermometer")
                        Label("Light low", systemImage: "sun.min")
                    }
                    .font(.caption)
                    .foregroundColor(.gray)
                }
                .padding([.horizontal, .bottom])
            }
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)

            Image(systemName: "drop.fill")
                .foregroundColor(.blue)
                .padding()
        }
        .padding(.horizontal)
    }

    func formattedAge(from date: Date) -> String {
        let age = Calendar.current.dateComponents([.year], from: date, to: Date()).year ?? 0
        return "\(age) year\(age == 1 ? "" : "s")"
    }
}

#Preview {
    HomeIndoorPlantView(plant: IndoorPlant(
        name: "Putica",
        weather: "Tropical",
        light: "Mucha",
        lastWatered: Date.now
    ))
}
