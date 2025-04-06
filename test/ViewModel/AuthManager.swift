//
//  AuthManager.swift
//  test
//
//  Created by Octavio Lara on 06/04/2025.
//

import Foundation
import KeychainAccess

class AuthManager: ObservableObject {
    @Published var isAuthenticated: Bool = false
    @Published var user: User? = nil

    private let keychain = Keychain(service: "com.yourapp.token")

    var token: String? {
        keychain["authToken"]
    }

    func login(withToken token: String, user: User) {
        keychain["authToken"] = token
        self.isAuthenticated = true
        self.user = user
    }

    func logout() {
        keychain["authToken"] = nil
        self.user = nil
        self.isAuthenticated = false
    }

    func fetchUser() async {
        guard let token = token else { return }
        print(token)
        do {
            let user = try await AuthApi.getUser(token: token)
            print(user)
            self.user = User(email: user.email, name: user.name, id: user._id)
            self.isAuthenticated = true
        } catch {
            print("Failed to fetch", error)
        }
                // Example API call to get user data
       
    }
}
