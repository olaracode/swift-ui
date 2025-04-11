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
    }
    
    static func getPlants(token: String) async throws -> [PlantModel] {
        let response: [PlantResponse] = try await fetch.get(
            endpoint: Endpoints.plants, token: token
        )
        print(response)
        return response.map {PlantModel(from: $0)}
    }
    static func createPlant(payload: PlantBody ,token: String) async throws -> PlantModel {
        print("CREATING PLANT ---------")
        print("🌱 Payload: \(payload)")
        let response: PlantResponse = try await fetch.post(
            endpoint: Endpoints.plants,
            payload: payload,
            token: token
        )
        print("🛜 Response: \(response)")
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
}

struct PlantBody: Codable {
    let name: String
    let weatherType: String
    let light: String
    let status: String
    let location: String
    let lastWatered: String
}
