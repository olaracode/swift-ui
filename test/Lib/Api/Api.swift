//
//  Api.swift
//  test
//
//  Created by Octavio Lara on 03/03/2025.
//

import Foundation

/// Enum that defines all possible API-related errors
enum ApiError: Error {
    case invalidUrl
    case serverError
    case invalidResponse
    case invalidData
    case badRequest
    case notFound
    case unauthenticated
}

/// API class to handle HTTP requests in a structured and reusable way
class Api {
    let baseUrl: String
    
    init(baseUrl: String){
        self.baseUrl = baseUrl
    }
    
    /// Builds the full URL from the given endpoint
    func getUrl(endpoint: String) throws -> URL {
        guard let url = URL(string: baseUrl + endpoint) else {
            throw ApiError.invalidUrl
        }
        return url
    }
    
    /// Validates the HTTP response status code
    func processResponse(response: URLResponse) throws{
        guard let httpResponse = response as? HTTPURLResponse else {
            throw ApiError.invalidResponse
        }
        guard (200...399).contains(httpResponse.statusCode) else {
            return try processError(statusCode: httpResponse.statusCode)
        }
    }
    
    /// Converts an HTTP status code to a specific ApiError
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
    
    /// Decodes JSON data into a Swift type
    func jsonDecoder<T: Codable>(data: Data) throws -> T{
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(T.self, from: data)
    }
    
    /// Builds a basic URLRequest with optional token and HTTP method
    func createRequest(
        url: URL,
        method: String? = "GET",
        token: String? = nil
    ) throws -> URLRequest{
        var request = URLRequest(url: url)
        request.httpMethod = method
        
        /// Adds Authorization header if token exists
        if let token = token {
            request.setValue(
                "Bearer \(token)", // value
                forHTTPHeaderField: "Authorization" // Header
            )
        }
        return request
    }
    
    /// Builds a request with a JSON payload body
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
    
    /// Sends a GET request and decodes the response into a Swift type
    func getData<T: Codable>(endpoint: String, token: String? = nil) async throws -> T {
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
    
    /// Sends a DELETE request to a given endpoint
    func deleteData(endpoint: String, token: String? = nil) async throws {
        let url = try getUrl(endpoint: endpoint)
        let request = try createRequest(url: url, method: "DELETE", token: token)
        let (_, response) = try await URLSession.shared.data(for: request)
        try processResponse(response: response)
        
    }
    
    /// Sends a PUT request with a payload and decodes the response
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



let api = Api(baseUrl: "http://localhost:8080")
