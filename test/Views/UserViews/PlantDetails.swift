//
//  PlantDetails.swift
//  test
//
//  Created by Octavio Lara on 13/04/2025.
//

import SwiftUI

struct PlantDetails: View {
    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject var plantManager: PlantManager
    @EnvironmentObject var authManager: AuthManager
    
    @State var isDeleteShown = false
    @State var hasNotification = false
    @State var notificationError = ErrorMessage()
    
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
                    HStack{
                        VStack(alignment: .leading, spacing: 4) {
                        
                            Text(plant.name)
                                .font(.largeTitle).bold()
                            Text("Ficus lyrata")
                                .font(.title3)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        Button("Delete", role: .destructive){
                            isDeleteShown.toggle()
                        }
                        .bold()
                        .confirmationDialog("Choose an action", isPresented: $isDeleteShown, titleVisibility: .visible) {
                                  Button("Confirm", role: .destructive) {
                                      Task {
                                          await deletePlant()
                                                                                }
                                     
                                  }
                                  Button("Cancel", role: .cancel) {}
                              }
                        
                        
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
                        Divider()
                            .padding(.vertical)
                        HStack {
                            
                            Toggle(isOn: $hasNotification){
                                Text("Vibrate on Ring")
                            }
                            .onChange(of: hasNotification) {
                                Task {
                                    print("Has notification\(hasNotification)")
                                    if hasNotification {
                                        await createNotification()
                                    }
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
        .onAppear {
            hasNotification = plant.hasNotification
        }
        
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
    
    func deletePlant() async {
        do {
            if let token = authManager.token {
                try await plantManager.deletePlant(
                    plantId: plant.id,
                    token: token
                )
                
                await MainActor.run {
                    print("Hey")
                    dismiss()
                }
            }
        }
        catch {
            print("Error \(error)")
        }
    }
    
    func createNotification() async {
        do {
            if let token = authManager.token {
                let newNotification = PlantNotification(notificationIdentifier: "plant:\(plant.name):\(plant.id)")
                try await plantManager.createNotification(
                    plantId: plant.id,
                    notification: newNotification,
                    token: token
                )
            }
        }
        catch {
            notificationError.show(msg: "There has been an error with this notification")
            hasNotification = false
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

#Preview {
    PlantDetails(plant: Placeholders.plant)
        .environmentObject(PlantManager())
        .environmentObject(AuthManager())
}
