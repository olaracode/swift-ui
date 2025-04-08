//
//  Fetch.swift
//  test
//
//  Created by Octavio Lara on 08/04/2025.
//

import Foundation

enum ApiError: Error {
    case invalidUrl
    case serverError
    case invalidResponse
    case invalidData
    case badRequest
    case notFound
    case unauthenticated
}

/// Rest API Fetch handler
struct Fetch {
    let baseUrl: String
    
    init(baseUrl: String){
        self.baseUrl = baseUrl
    }
}

//let fetch = Fetch(baseUrl: "http://localhost:8080")
