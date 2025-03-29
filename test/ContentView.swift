//
//  ContentView.swift
//  test
//
//  Created by Octavio Lara on 26/03/2025.
//

import SwiftUI
import SwiftData
struct ContentView: View {
    @Environment(\.modelContext) var context
    
    @State private var cached: Bool = false
    @Query() var githubUsers: [GithubUser]
    var body: some View {
        ProfileView(githubUser: githubUsers.first)
        .padding()
        // Adds asyncronous task
        .task {
            if githubUsers.first != nil {
                cached = true
                return
            }
            do {
                let apiUser = try await GithubApi().getUser(username: "olaracode")
                let githubUser = GithubUser(
                    login: apiUser.login,
                    avatarUrl: apiUser.avatarUrl,
                    bio: apiUser.bio
                )
                context.insert(githubUser)
                
            } catch GithubError.invalidURL {
                print("Invalid Url")
                //
            } catch GithubError.invalidResponse {
                print("Invalid Response")
            } catch GithubError.invalidData {
                print("Invalid Data")
            } catch {
                print("Unhandled unknown error")
            }
        }
    }
}

#Preview {
    ContentView()
}
