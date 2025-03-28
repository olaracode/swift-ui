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
    var body: some View {
        NavigationStack{
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
                ZStack {
                    platform.color.ignoresSafeArea()
                    Label(platform.name, systemImage: platform.imageName)
                        .font(.largeTitle).bold()
                }
            }
            .navigationDestination(for: Game.self){ game in
                    Text("\(game.name) - \(game.rating)")
                        .font(.largeTitle.bold())
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
