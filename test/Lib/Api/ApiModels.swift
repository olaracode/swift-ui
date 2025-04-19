//
//  AuthApi.swift
//  test
//
//  Created by Octavio Lara on 06/04/2025.
//

// Should rename this file!

import Foundation

/// This file is created to contain all the models related to the bodies / responses
/// Maybe should be broken into multiple files, but the idea is to leave all the Api + Domain
/// free of all struct | enum clutter

enum AuthRequestError: Error {
    case invalidEmailOrPassword
}

/// Api + Auth
struct LoginBody: Codable {
    var email: String
    var password: String
    init(email: String, password: String){
        self.email = email
        self.password = password
    }
}

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


/// Api+Plants
struct PlantBody: Codable {
    let name: String
    let weatherType: String
    let light: String
    let status: String
    let location: String
    let lastWatered: String
    let wateringIntervalHours: Int
}

struct PlantResponse: Codable {
    let _id: String
    let name: String
    let light: String
    let weatherType: String
    let status: String
    let location: String
    let lastWatered: String
    let user: String
    let nextWatering: String
    let wateringIntervalHours: Int
    let careNote: String?
    let notificationIdentifier: String?
}

struct CareNoteBody: Codable {
    let careNote: String
}

struct PlantNotification: Codable {
    let notificationIdentifier: String
}
