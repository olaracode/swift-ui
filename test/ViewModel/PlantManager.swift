//
//  PlantManager.swift
//  test
//
//  Created by Octavio Lara on 08/04/2025.
//

import Foundation
import SwiftUI
class PlantManager: ObservableObject {
    @Published var plants: [PlantModel]
    var plantsNeedingWater: [PlantModel] {
        plants.filter { $0.needsWatering }
    }
    init(){
       plants = []
    }
    
    /// API related methods
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
    
    func waterPlant(plantId: String, token: String) async throws {
        let updatedPlant = try await Api.waterPlant(plantId: plantId, token: token)
        
        DispatchQueue.main.async {
            if let index = self.plants.firstIndex(where: { $0.id == plantId }){
                withAnimation {
                    self.plants[index] = updatedPlant

                }
            }
        }
    }
    
    func deletePlant(plantId: String, token: String) async throws {
        let _ = try await Api.deletePlant(plantId: plantId, token: token)
        DispatchQueue.main.async {
            if let index = self.plants.firstIndex(where: { $0.id == plantId }){
                self.plants.remove(at: index)
            }
        }
    }
    
    func updateCareNote(
        plantId: String,
        payload: CareNoteBody,
        token: String
    ) async throws {
        let updatedPlant = try await Api.updateCardNote(
            plantId: plantId,
            payload: payload,
            token: token
        )
        DispatchQueue.main.async {
            if let index = self.plants.firstIndex(where: { $0.id == plantId }){
                withAnimation {
                    self.plants[index] = updatedPlant
                }
            }
        }
    }
    
    func clean(){
        plants = []
    }
}
