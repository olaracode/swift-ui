//
//  GithubApi.swift
//  test
//
//  Created by Octavio Lara on 29/03/2025.
//

import Foundation
class GithubApi {
    let baseUrl = "https://api.github.com/"

    func getUrl(endpoint: String) throws -> URL {
        guard let url = URL(string: endpoint) else {
            throw GithubError.invalidURL
        }
        return url
    }
    func getUser(username: String) async throws -> GithubProfileResponse{
        let endpoint = baseUrl + "users/" + username
        let url = try getUrl(endpoint: endpoint)
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        // Check if response is valid, if not throw error
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw GithubError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            // transform from json using GithubProfile.self to cast
            return try decoder.decode(GithubProfileResponse.self , from: data)
        } catch{
            throw GithubError.invalidData
        }
    }
}
