//
//  Fetch+URL.swift
//  test
//
//  Created by Octavio Lara on 08/04/2025.
//

import Foundation

extension Fetch {
    func getUrl(endpoint: String) throws -> URL {
        guard let url = URL(string: baseUrl + endpoint) else {
            throw ApiError.invalidUrl
        }
        return url
    }
}
