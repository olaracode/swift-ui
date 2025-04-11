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
    @Published var isLoading: Bool = false
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

    func load(_ isLoading: Bool = true){
        DispatchQueue.main.async {
            self.isLoading = isLoading

        }
    }
    func fetchUser() async {
        guard let token = token else { return }
        print(token)
        do {
            let user = try await Api.getUser(token: token)
            print(user)
            DispatchQueue.main.async {
                self.user = User(email: user.email, name: user.name, id: user._id)
                self.isAuthenticated = true
                self.load(false)
            }

//            self.user = User(email: user.email, name: user.name, id: user._id)
//            self.isAuthenticated = true
        } catch {
          DispatchQueue.main.async {
            self.load(false)
          }
        }
                // Example API call to get user data
       
    }
}
