//
//  User.swift
//  test
//
//  Created by Octavio Lara on 04/04/2025.
//

import Foundation

struct User: Codable {
    var email: String
    var name: String
    var id: String
    
    init(email: String, name: String, id: String){
        self.email = email
        self.name = name
        self.id = id
    }
}

struct UserResponse: Codable {
    var email: String
    var name: String
    var _id: String
    
    init(email: String, name: String, id: String){
        self.email = email
        self.name = name
        self._id = id
    }
}
