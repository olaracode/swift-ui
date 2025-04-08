//
//  AuthApi.swift
//  test
//
//  Created by Octavio Lara on 06/04/2025.
//

// Should rename this file!

import Foundation

enum AuthRequestError: Error {
    case invalidEmailOrPassword
}

struct LoginBody: Codable {
    var email: String
    var password: String
    init(email: String, password: String){
        self.email = email
        self.password = password
    }
}

// extend login type for register wich adds Name
struct RegisterBody: Codable {
    var email: String
    var name: String
    var password: String
    
    init(email: String, password: String, name: String){
        self.email = email
        self.name = name
        self.password = password
    }
}

struct RegisterLoginResponse: Codable {
    var _id: String
    var name: String
    var email: String
    var token: String
    
    init(_id: String, name: String, token: String, email: String){
        self._id = _id
        self.name = name
        self.email = email
        self.token = token
    }
}
