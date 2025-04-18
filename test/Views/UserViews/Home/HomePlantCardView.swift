//
//  HomePlantCardView.swift
//  test
//
//  Created by Octavio Lara on 16/04/2025.
//
import SwiftUI

struct HomePlantCardView: View {
    @EnvironmentObject var plantManager: PlantManager
    @EnvironmentObject var authManager: AuthManager
    let plant: PlantModel
    
    var body: some View{
        HStack {
            
            Image("philodendron")
                .resizable()
                .frame(width: 100, height: 120)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            
            
            VStack(alignment: .leading) {
                
                HStack(alignment: .center) {
                    Text(plant.name)
                        .font(.title)
                    HStack(alignment: .center) {
                        Text(plant.status.label) // or "Need watering"
                            .font(.caption)
                        Circle()
                            .frame(width: 9, height: 9)
                            .foregroundColor(plant.status.color)
                    }
                }
                Text(plant.location.label)
                Spacer()
                
            }
            Spacer()
            VStack(){
                Spacer()
                Button("Water") {
                    Task {
                        await waterPlant()
                    }
                }
            }
            
            
        }
        .padding()
        .background()
        .cornerRadius(16)
        .shadow(radius: 0.8)
        .containerRelativeFrame(.horizontal)
    }
    func waterPlant() async {
        do {
            if let token = authManager.token {
                try await plantManager.waterPlant(
                    plantId: plant.id,
                    token: token
                )
            }
        } catch {
            print(error)
        }
        
    }
}

#Preview {
    HomePlantCardView(plant: Placeholders.plant)
        .environmentObject(PlantManager())
        .environmentObject(AuthManager())
}
