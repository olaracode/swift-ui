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
        ZStack{
            if let selectedPlant {
                PlantDetailView(plant: selectedPlant, namespace: plantNamespace, discard: discard)
            } else {
                VStack {
                    HStack {
                        Text("My garden")
                            .font(.title)
                            .bold()
                            .foregroundColor(Color.appBackground)
                        Spacer()
                        Button{
                           showingAddPlantSheet = true
                        } label: {
                            Image(systemName: "plus")
                        }
                        .padding(12)
                        .background(Color.appBackground.opacity(0.8))
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .shadow(radius: 3)

         
                        
                    }
                    ScrollView{
                    
                        LazyVStack(alignment: .leading) {
                            if plantManager.plants.isEmpty {
                                Text("No plants")
                            }else {
                                ForEach(plantManager.plants) { plant in
                                    PlantCardView(plant: plant, namespace: plantNamespace)
                                        .onTapGesture {
                                            withAnimation{
                                                show(plant: plant)
                                            }
                                        }
                                }
                            }
                        }
                    }
                }
                .opacity(selectedPlant != nil ? 0 : 1)
                .padding()
            }
        }
        .sheet(isPresented: $showingAddPlantSheet){
            AddPlantView()
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
