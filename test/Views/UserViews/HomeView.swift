//
//  HomeView.swift
//  test
//
//  Created by Octavio Lara on 07/04/2025.
//

import SwiftUI

struct HomeView: View {
    @State var plants: [IndoorPlant] = [
        IndoorPlant(
            name: "Putica",
            weather: "Tropical",
            light: "Mucha",
            lastWatered: Date.now
        ),
        IndoorPlant(
            name: "Putica",
            weather: "Tropical",
            light: "Mucha",
            lastWatered: Date.now
        ),
        IndoorPlant(
            name: "Putica",
            weather: "Tropical",
            light: "Mucha",
            lastWatered: Date.now
        )
    ]
    var body: some View {
        NavigationStack {
                VStack{
                    HStack {
                        Text("My garden")
                            .font(.title)
                            .bold()
                            .foregroundColor(Color.appBackground)
                        Spacer()
                        Button{
                            
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
                    
                    VStack(alignment: .leading) {
                        ForEach(plants) { plant in
                            HomeIndoorPlantView(plant: plant)
                        }
                    }
                   
                    Spacer()
                }
            }
            
        }
        .padding()
        
    }
}

#Preview {
    HomeView()
}


protocol Plant {
    var id: UUID { get set }
    var name: String { get set }
    var weather: String { get set }
    var light: String {get set}
}

struct IndoorPlant: Plant, Identifiable {
    var id: UUID = UUID()
    var name: String
    var weather: String
    var light: String
    var lastWatered: Date = Date()
}
