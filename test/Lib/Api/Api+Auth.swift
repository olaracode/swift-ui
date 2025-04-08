//
//  Api+Auth.swift
//  test
//
//  Created by Octavio Lara on 08/04/2025.
//

import Foundation

extension Api {
    private struct Endpoints {
        static let login = "/v1/auth/login"
        static let register = "/v1/auth/register"
        static let me = "/v1/auth/me"
    }
    static func login(loginBody: LoginBody)async throws -> RegisterLoginResponse{
        do {
            let response: RegisterLoginResponse = try await fetch.post(
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
            let response: RegisterLoginResponse = try await fetch.post(endpoint: "/v1/auth/register", payload: body)
            return response
        } catch {
            throw ApiError.serverError
        }
    }
    static func getUser(
        token: String
    ) async throws -> UserResponse {
        let response: UserResponse = try await fetch.get(endpoint: Endpoints.me, token: token)
        return response
    }
}
