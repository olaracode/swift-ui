//
//  Fetch+HTTPMethods.swift
//  test
//
//  Created by Octavio Lara on 08/04/2025.
//

import Foundation

/// GET | POST | PUT | DELETE methods
extension Fetch {
    func get<T: Codable>(
        endpoint: String,
        token: String? = nil
    ) async throws -> T {
        let url = try getUrl(endpoint: endpoint)
        let request = try createRequest(url: url, token: token)
        let (data, response) = try await URLSession.shared.data(for: request)
        try processResponse(response: response)
        do {
            return try jsonDecoder(data: data)
        } catch {
            throw ApiError.invalidData
        }
    }
    
    /// Sends a POST request with a payload and decodes the response
    func post<T: Codable, U: Codable>(
        endpoint: String,
        payload: T,
        token: String? = nil)
    async throws -> U {
        let url = try getUrl(endpoint: endpoint)
        let request = try createRequestWithBody(url: url, payload: payload, token: token)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        try processResponse(response: response)
        
        do {
            return try jsonDecoder(data: data)
        } catch {
            print("Decoding error", error)
            throw ApiError.invalidData
        }
    }
    
    /// Sends a DELETE request to a given endpoint
    func delete(
        endpoint: String,
        token: String? = nil
    ) async throws {
        let url = try getUrl(endpoint: endpoint)
        let request = try createRequest(url: url, method: "DELETE", token: token)
        let (_, response) = try await URLSession.shared.data(for: request)
        try processResponse(response: response)
        
    }
    
    /// Sends a PUT request with a payload and decodes the response
    func put<T: Codable>(
        endpoint: String,
        payload: T,
        token: String? = nil
    ) async throws -> T{
        let url = try getUrl(endpoint: endpoint)
        let request = try createRequestWithBody(url: url, payload: payload, method: "PUT", token: token)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        try processResponse(response: response)
        
        do {
            return try jsonDecoder(data: data)
        } catch {
            print("Decoding error", error)
            throw ApiError.invalidData
        }
        
    }
}
