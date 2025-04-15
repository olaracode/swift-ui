//
//  Api+Plants.swift
//  test
//
//  Created by Octavio Lara on 08/04/2025.
//

import Foundation



extension Api {
    private struct Endpoints {
        static let plants = "/v1/plants"
        static let water = "\(Endpoints.plants)/water"
        static let cardNote = "\(Endpoints.plants)/card-note"
        
    }
    
    static func getPlants(token: String) async throws -> [PlantModel] {
        let response: [PlantResponse] = try await fetch.get(
            endpoint: Endpoints.plants, token: token
        )
        return response.map {PlantModel(from: $0)}
    }
    
    static func createPlant(
        payload: PlantBody,
        token: String
    ) async throws -> PlantModel {
        let response: PlantResponse = try await fetch.post(
            endpoint: Endpoints.plants,
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
            endpoint: "\(Endpoints.plants)/\(plantId)",
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
}



struct PlantResponse: Codable {
    let _id: String
    let name: String
    let light: String
    let weatherType: String
    let status: String
    let location: String
    let lastWatered: String
    let user: String
    let nextWatering: String
    let wateringIntervalHours: Int
    let careNote: String?
}

struct PlantBody: Codable {
    let name: String
    let weatherType: String
    let light: String
    let status: String
    let location: String
    let lastWatered: String
    let wateringIntervalHours: Int
}

struct CareNoteBody: Codable {
    let careNote: String
}
