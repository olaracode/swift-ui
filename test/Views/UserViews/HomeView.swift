//
//  HomeView.swift
//  test
//
//  Created by Octavio Lara on 07/04/2025.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var plantManager: PlantManager
    @EnvironmentObject var auth: AuthManager
    
    @Namespace var plantNamespace
    
    @State private var showingAddPlantSheet = false
    @State private var showDetails = false
    @State private var selectedPlant: PlantModel?
    var body: some View {
        ZStack{
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
                        ForEach(plantManager.plants) { plant in
                            HomeIndoorPlantView(plant: plant, namespace: plantNamespace)
                                .onTapGesture {
                                    withAnimation {
                                        self.selectedPlant = plant
                                        self.showDetails = true
                                    }
                                }
                        }
                    }
                }
            }
            .padding()
            if let selectedPlant {
              
               PlantDetailsView(plant: selectedPlant, namespace: plantNamespace)
                   .zIndex(1)
                   .onTapGesture {
                       withAnimation {
                           self.selectedPlant = nil
                       }
                       
                   }
                  
                   
                   
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

}

#Preview {

    HomeView()
        .environmentObject(PlantManager())
        .environmentObject(AuthManager())
}
