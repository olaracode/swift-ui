//
//  HomeView.swift
//  test
//
//  Created by Octavio Lara on 07/04/2025.
//

import SwiftUI

struct PlantListView: View {
    @EnvironmentObject var plantManager: PlantManager
    @EnvironmentObject var auth: AuthManager
    
    @Namespace var plantNamespace
    
    @State private var showingAddPlantSheet = false
    @State private var showDetails = false
    @State private var selectedPlant: PlantModel?
    var body: some View {
     
        NavigationStack {
            VStack(alignment: .leading, spacing: 10){
            
                    Header()
                    List {
                        ForEach(plantManager.plants) { plant in
                            NavigationLink(destination: PlantDetails(plant: plant)) {
                                HStack(spacing: 16) {
                                    Image("philodendron")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 60, height: 60)
                                        .clipShape(RoundedRectangle(cornerRadius: 12))
                                    
                                    VStack(alignment: .leading, spacing: 4) {
                                        HStack {
                                            Text(plant.name)
                                                .font(.headline)
                                            Text(plant.lastWatered ?? "")
                                                .font(.caption)
                                        }
                                        HStack {
                                            Text(plant.location.label)
                                                .font(.caption)
                                            Text("\(plant.status.label)\(plant.status.emoji)")
                                                .font(.caption2)
                                                .fontWeight(.light)
                                                .foregroundColor(plant.status.color.opacity(0.8))
                                        }
                                       
                                        
                                    }
                                    
                                    Spacer()
                                    
                                    
                                }
                                .padding(.vertical, 8)
                            }
                        }
                       
                }
                    
            }
            .padding(.top)
            .background(Color(.systemGray6))
            .navigationBarHidden(true)
           
        }
        
    }
    func fetchPlants() async {
        do {
            if let token = auth.token {
                try await plantManager.getPlants(token: token)

            }
        } catch {
            print("Error fetching plants: \(error)")
        }
    }
    
    func discard(){
        showDetails.toggle()
        selectedPlant = nil
    }
    func show(plant: PlantModel){
        print("Showing: \(plant.name)")
        selectedPlant = plant
        showDetails.toggle()
    }

}

#Preview {

    PlantListView()
        .environmentObject(PlantManager())
        .environmentObject(AuthManager())
}
