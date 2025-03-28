//
//  GameView.swift
//  test
//
//  Created by Octavio Lara on 28/03/2025.
//

import SwiftUI

struct GameView: View {
    let game: Game
    let platforms: [Platform]
    var body: some View {
        VStack {
            Text("\(game.name) - \(game.rating)")
                .font(.largeTitle.bold())
            List {
                ForEach(platforms){ platform in
                    NavigationLink(value: platform){
                        Label(platform.name, systemImage: platform.imageName)
                            .foregroundStyle(platform.color)
                    }
                }
            }
        }
    }
}

#Preview {
    GameView(
        game: Game(name: "Madden", rating: "89"),
        platforms: []
    )
}
