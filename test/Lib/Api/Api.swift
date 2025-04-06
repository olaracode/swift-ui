//
//  Api.swift
//  test
//
//  Created by Octavio Lara on 03/03/2025.
//

import Foundation

class Api {
    let baseUrl: String
    
    init(baseUrl: String){
        self.baseUrl = baseUrl
    }
    
    func getUrl(endpoint: String) throws -> URL {
        guard let url = URL(string: baseUrl + endpoint) else {
            throw ApiError.invalidUrl
        }
        return url
    }
    
    func processResponse(response: URLResponse) throws{
        guard let httpResponse = response as? HTTPURLResponse else {
            throw ApiError.invalidResponse
        }
        guard (200...299).contains(httpResponse.statusCode) else {
            return try processError(statusCode: httpResponse.statusCode)
        }
    }
    
    func processError(statusCode: Int) throws {
        switch statusCode {
        case 400:
            throw ApiError.badRequest
        case 404:
            throw ApiError.notFound
        default:
            throw ApiError.serverError
        }
    }
    
    func jsonDecoder<T: Codable>(data: Data) throws -> T{
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        print("decoder")
        print(T.self)
        try print(decoder.decode(T.self, from: data))
        return try decoder.decode(T.self, from: data)
    }
    
    func getData<T: Codable>(endpoint: String, token: String? = nil) async throws -> T {
        let url = try getUrl(endpoint: endpoint)
        let request = try createRequest(url: url, token: token)
        let (data, response) = try await URLSession.shared.data(from: url)
        try processResponse(response: response)
        do {
            return try jsonDecoder(data: data)
        } catch {
            throw ApiError.invalidData
        }
    }
    
    // T is the Payload Type
    // U is the response Type
    func postData<T: Codable, U: Codable>(endpoint: String, payload: T, token: String? = nil) async throws -> U {
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
    
    func deleteData(endpoint: String, token: String? = nil) async throws {
        let url = try getUrl(endpoint: endpoint)
        let request = try createRequest(url: url, method: "DELETE", token: token)
        let (_, response) = try await URLSession.shared.data(for: request)
        try processResponse(response: response)
        
    }
    
    func createRequest(
        url: URL,
        method: String? = "POST",
        token: String? = nil
    ) throws -> URLRequest{
        var request = URLRequest(url: url)
        request.httpMethod = method
        if token != nil {
            request.setValue(
                "Bearer \(token ?? "")", // value
                forHTTPHeaderField: "Authorization" // Header
            )
        }
        return request
    }
    
    func createRequestWithBody<T: Codable>(
        url: URL,
        payload: T?,
        method: String? = "POST",
        token: String? = nil
    ) throws -> URLRequest {
        var request = try createRequest(url: url, method: method, token: token)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(payload)
        return request
    }
    
    func putData<T: Codable>(endpoint: String, payload: T, token: String? = nil) async throws -> T{
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

enum ApiError: Error {
    case invalidUrl
    case serverError
    case invalidResponse
    case invalidData
    case badRequest
    case notFound
    case unauthenticated
}

let api = Api(baseUrl: "http://localhost:8080")
