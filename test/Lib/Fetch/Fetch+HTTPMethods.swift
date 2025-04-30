//
//  Fetch+HTTPMethods.swift
//  test
//
//  Created by Octavio Lara on 08/04/2025.
//

import Foundation

/// GET | POST | PUT | DELETE methods
extension Fetch {
    func request<T: Codable>(req: URLRequest) async throws -> T {
        let (data, response) = try await URLSession.shared.data(for: req)
        try processResponse(response: response)
        do {
            return try jsonDecoder(data: data)
        } catch {
            print("Decoding error", error)
            throw ApiError.invalidData
        }
    }
    func get<T: Codable>(
        endpoint: String,
        token: String? = nil
    ) async throws -> T {
        let req = try createRequest(endpoint: endpoint, token: token)
        return try await request(req: req)
//        let (data, response) = try await URLSession.shared.data(for: request)
//        try processResponse(response: response)
//        do {
//            return try jsonDecoder(data: data)
//        } catch {
//            throw ApiError.invalidData
//        }
    }
    
    /// Sends a POST request with a payload and decodes the response
    func post<T: Codable, U: Codable>(
        endpoint: String,
        payload: T,
        token: String? = nil)
    async throws -> U {
        let req = try createRequestWithBody(endpoint: endpoint, payload: payload, token: token)
        
        let (data, response) = try await URLSession.shared.data(for: req)
        print(data)
        try processResponse(response: response)
        
        do {
            print("decoding")
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
        let request = try createRequest(endpoint: endpoint, method: "DELETE", token: token)
        let (_, response) = try await URLSession.shared.data(for: request)
        try processResponse(response: response)
        
    }

//    / Sends a delete with a response
    func delete<T: Codable>(
        endpoint: String,
        token: String? = nil
    ) async throws -> T {
        let req = try createRequest(endpoint: endpoint, method: "DELETE", token: token)
        return try await request(req: req)
//        return data
    }
    
    /// Sends a PUT request with a payload and decodes the response
    func put<T: Codable, U: Codable>(
        endpoint: String,
        payload: T,
        token: String? = nil
    ) async throws -> U{
        let request = try createRequestWithBody(
            endpoint: endpoint,
            payload: payload,
            method: "PUT",
            token: token
        )
      
         
        
        let (data, response) = try await URLSession.shared.data(for: request)
        try processResponse(response: response)
        
        do {
            return try jsonDecoder(data: data)
        } catch {
            print("Decoding error", error)
            throw ApiError.invalidData
        }
        
    }
    func put<U: Codable>(
        endpoint: String,
        token: String? = nil
    ) async throws -> U{
        
        let request = try createRequest(
            endpoint: endpoint,
            method: "PUT",
            token: token
        )

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
