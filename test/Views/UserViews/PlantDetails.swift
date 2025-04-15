//
//  PlantDetails.swift
//  test
//
//  Created by Octavio Lara on 13/04/2025.
//

import SwiftUI

struct PlantDetails: View {
    @EnvironmentObject var plantManager: PlantManager
    @EnvironmentObject var authManager: AuthManager
    let plant: PlantModel
    var body: some View {
        NavigationView{
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    
                    // Plant Image
                    Image("fiddle-leaf-fig")
                        .resizable()
                        .scaledToFill()
                        .frame(height: 250)
                        .clipped()
                        .cornerRadius(20)
                        .padding(.horizontal)

                    // Name & Species
                    VStack(alignment: .leading, spacing: 4) {
                        Text(plant.name)
                            .font(.largeTitle).bold()
                        Text("Ficus lyrata")
                            .font(.title3)
                            .foregroundColor(.secondary)
                    }
                    .padding(.horizontal)

                    Divider()
                        .padding(.horizontal)

                    // Watering Info
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Image(systemName: "drop.fill")
                                .foregroundColor(.blue)
                            Text("Water once \(getWateringPeriodText())")
                                .font(.headline)
                        }

                        HStack {
                            Image(systemName: "calendar")
                            Text("Last watered: \(plant.lastWatered ?? "")")
                        }

                        HStack {
                            Image(systemName: "clock")
                            HStack(alignment: .center) {
                                Text("Next watering:")
                                if plant.needsWatering {
                                    Text("Needs watering")
                                        .bold()
                                        .foregroundColor(.red.opacity(0.8))
                                }else {
                                    CountdownView(targetDate: plant.nextWatering ?? Date.now)
                                }
                                
                            }
                           
                        }

                        Button(action: {
                                Task {
                                    await waterPlant()
                                }
                            
                        }) {
                            Label("\(plant.needsWatering ? "Water me 🥵" : "Watered 😎")", systemImage: plant.needsWatering ? "circle" : "checkmark.circle.fill")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.green.opacity(plant.needsWatering ? 1 : 0.2))
                                .foregroundColor(.white)
                                .cornerRadius(12)
                        }
                        .padding(.top)
                        .disabled(!plant.needsWatering)
                        
                    }
                    .padding(.horizontal)

                    // Notes
                    PlantCareNote(plant: plant)
                }
                .padding(.vertical)
            }
            .background(Color(.systemGray6))
       

        }
        .navigationTitle(plant.name)
        .navigationBarTitleDisplayMode(.inline)
        
    }
    func waterPlant() async {
        do {
            try await plantManager.waterPlant(
                plantId: plant.id,
                token: authManager.token ?? ""
            )
        }
        catch {
            print("Error \(error)")
        }
       
    }
    
    func getWateringPeriodText() -> String {
        if plant.wateringIntervalHours % 24 > 0 {
            return "every \(plant.wateringIntervalHours) hours"
        }
        let days = plant.wateringIntervalHours / 24
        return "every \(days) day\(days > 1 ? "s" : "")"
    }

}
struct CountdownView: View {
    let targetDate: Date
    @State private var now = Date()
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        Text(displayText)
            .fontWeight(.light)
            .onReceive(timer) { _ in
                now = Date()
            }
    }

    var displayText: String {
        let diff = targetDate.timeIntervalSince(now)
        
        if diff > 24 * 60 * 60 {
            // More than 24 hours: show formatted date
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            return formatter.string(from: targetDate)
        } else if diff > 0 {
            // Less than 24 hours: show countdown
            let hours = Int(diff) / 3600
            let minutes = (Int(diff) % 3600) / 60
            let seconds = Int(diff) % 60
            return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        } else {
            return "Time's up!"
        }
    }
}

struct PlantCareNote: View {
    var plant: PlantModel
    var body: some View {
        NavigationLink(destination: PlantCareNoteView(plant: plant)) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Care Notes")
                    .font(.headline)

                if plant.careNote == nil {
                    Text("No care note defined")
                        .foregroundColor(.gray)
                } else {
                    Text(plant.careNote ?? "")
                        .foregroundColor(.secondary)
                }
            }
            .padding(.horizontal)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    PlantDetails(plant: Placeholders.plant)
        .environmentObject(PlantManager())
        .environmentObject(AuthManager())
}
