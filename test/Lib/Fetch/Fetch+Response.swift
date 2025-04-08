//
//  Fetch+Response.swift
//  test
//
//  Created by Octavio Lara on 08/04/2025.
//

import Foundation

extension Fetch {
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
}
