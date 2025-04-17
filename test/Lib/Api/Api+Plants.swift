//
//  Api+Plants.swift
//  test
//
//  Created by Octavio Lara on 08/04/2025.
//

import Foundation

extension Api {
    private struct Endpoints {
        static let base = "/v1/plants"
        static let water = "\(Endpoints.base)/water"
        static let cardNote = "\(Endpoints.base)/card-note"
    }
    
    static func getPlants(token: String) async throws -> [PlantModel] {
        let response: [PlantResponse] = try await fetch.get(
            endpoint: Endpoints.base, token: token
        )
        return response.map {PlantModel(from: $0)}
    }
    
    static func createPlant(
        payload: PlantBody,
        token: String
    ) async throws -> PlantModel {
        let response: PlantResponse = try await fetch.post(
            endpoint: Endpoints.base,
            payload: payload,
            token: token
        )
        return PlantModel(from: response)
    }
    
    static func waterPlant(
        plantId: String,
        token: String
    ) async throws -> PlantModel {
        let response: PlantResponse = try await fetch.put(
            endpoint: "\(Endpoints.water)/\(plantId)",
            token: token
        )
        return PlantModel(from: response)
    }
    
    static func updateCardNote(
        plantId: String,
        payload: CareNoteBody,
        token: String
    ) async throws -> PlantModel {
            let response: PlantResponse = try await fetch.put(
                endpoint: "\(Endpoints.cardNote)/\(plantId)",
                payload: payload,
                token: token
            )
            
            return PlantModel(from: response)
    }
    
    static func deletePlant(
        plantId: String,
        token: String
    ) async throws {
       try await fetch.delete(
            endpoint: "\(Endpoints.base)/\(plantId)",
            token: token
        )
    }
}



