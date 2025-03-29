//
//  ProfileView.swift
//  test
//
//  Created by Octavio Lara on 29/03/2025.
//

import SwiftUI
import SwiftData
struct ProfileView: View {
    let githubUser: GithubUser?
    let cached: Bool = false
    var body: some View {
        VStack(spacing: 20) {
            AsyncImage(url: URL(string: githubUser?.avatarUrl ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
            } placeholder: {
                Circle()
                    .foregroundColor(.secondary)
                                        
            }
            .frame(width: 128, height: 120)

           
            Text(githubUser?.login ?? "Login Placeholder ...")
                .bold()
                .font(.title3)
            Text(githubUser?.bio ?? "Bio placeholder ...")
                .padding()
            if(cached){
                Text("Cached Value")
                    .font(.caption2)
            }
            Spacer()
        }
    }
}

#Preview {
    ProfileView(githubUser: nil)
}
