//
//  PlantManager.swift
//  test
//
//  Created by Octavio Lara on 08/04/2025.
//

import Foundation

class PlantManager: ObservableObject {
    @Published var plants: [PlantModel]
    init(){
       plants = []
    }
    
    func getPlants(token: String) async throws {
        let apiPlants = try await Api.getPlants(token: token)
        DispatchQueue.main.async {
            self.plants.append(contentsOf: apiPlants)
        }
    }
    
    func addPlant(payload: PlantBody, token: String) async throws{
        let newPlant = try await Api.createPlant(payload: payload, token: token)
        DispatchQueue.main.async {
            self.plants.append(newPlant)
        }
    }
    
    func clean(){
        plants = []
    }
}
