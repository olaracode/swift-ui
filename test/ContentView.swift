//
//  ContentView.swift
//  test
//
//  Created by Octavio Lara on 26/03/2025.
//

import SwiftUI

struct ContentView: View {
    var platforms: [Platform] = [
        .init(name: "Xbox", imageName: "xbox.logo", color: .green),
        .init(name: "Playstation", imageName: "playstation.logo", color: .indigo),
        .init(name: "PC", imageName: "pc", color: .pink),
        .init(name: "Mobile", imageName: "iphone", color: .mint)
    ]
    
    var games: [Game] = [
        .init(name: "Madden 2026", rating: "80"),
        .init(name: "Elden Ring", rating: "99"),
        .init(name: "Call of Duty", rating: "100"),
        .init(name: "Stardew Valley", rating: "89"),
        .init(name: "It takes two", rating: "80"),
        .init(name: "Space Marine", rating: "95"),
    ]
    // To actually use stackable navigation
    // meaning one path on top of another
    // we need to declare a navigation path
    @State private var path = NavigationPath()
    var body: some View {
        NavigationStack(path: $path){
            List {
                Section("Platforms") {
                    ForEach(platforms){ platform in
                        NavigationLink(value: platform){
                            Label(platform.name, systemImage: platform.imageName)
                                .foregroundStyle(platform.color)
                        }
                    }
                }
                Section("Games") {
                    ForEach(games){ game in
                        NavigationLink(value: game){
                            Text(game.name)
                        }
                    }
                }
            }
            .navigationTitle("Gaming")
            .navigationDestination(for: Platform.self){ platform in
                PlatformView(platform: platform, games: games)
            }
            .navigationDestination(for: Game.self){ game in
                GameView(game:game, platforms: platforms)
            }
        }
    }
}

#Preview {
    ContentView()
}
struct Platform: Identifiable, Hashable {
    let name: String
    let imageName: String
    let color: Color
    let id = UUID()
}
struct Game: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let rating: String
}
