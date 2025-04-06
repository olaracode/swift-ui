//
//  AuthApi.swift
//  test
//
//  Created by Octavio Lara on 06/04/2025.
//

import Foundation

struct AuthApi {
    private struct Endpoints {
        static let login = "/v1/auth/login"
        static let register = "/v1/auth/register"
        static let me = "/v1/auth/me"
    }
    static func login(loginBody: LoginBody)async throws -> RegisterLoginResponse{
        do {
            let response: RegisterLoginResponse = try await api.postData(
                endpoint: Endpoints.login,
                payload: loginBody
            )
            return response
        }
        catch ApiError.unauthenticated {
            throw AuthRequestError.invalidEmailOrPassword
        }
        catch {
            throw ApiError.serverError
        }
    }
    
    static func register(body: RegisterBody) async throws -> RegisterLoginResponse {
        do {
            let response: RegisterLoginResponse = try await api.postData(endpoint: "/v1/auth/register", payload: body)
            return response
        } catch {
            throw ApiError.serverError
        }
    }
    static func getUser(
        token: String
    ) async throws -> UserResponse {
        let response: UserResponse = try await api.getData(endpoint: Endpoints.me, token: token)
        return response
    }
}
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
