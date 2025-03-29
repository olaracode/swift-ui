//
//  GithubModel.swift
//  test
//
//  Created by Octavio Lara on 29/03/2025.
//

import Foundation
import SwiftData

@Model
class GithubUser {
    var login: String
    var avatarUrl: String
    var bio: String
    init(login: String, avatarUrl: String, bio: String) {
        self.login = login
        self.avatarUrl = avatarUrl
        self.bio = bio
    }
}

struct GithubProfileResponse: Codable {
    let login: String
    let avatarUrl: String
    let bio: String
}


enum GithubError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}
