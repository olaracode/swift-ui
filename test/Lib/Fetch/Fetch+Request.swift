//
//  Fetch+Request.swift
//  test
//
//  Created by Octavio Lara on 08/04/2025.
//

import Foundation

/// Handle the creation of the Requests
extension Fetch {
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
}
