//
//  PlatformView.swift
//  test
//
//  Created by Octavio Lara on 28/03/2025.
//

import SwiftUI

struct PlatformView: View {
    let platform: Platform
    let games: [Game]
    var body: some View {
        ZStack {
            platform.color.ignoresSafeArea()
            VStack{
            
                Label(platform.name, systemImage: platform.imageName)
                    .font(.largeTitle).bold()
                List {
                    ForEach(games){ game in
                        NavigationLink(value: game){
                            Text(game.name)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    PlatformView(platform: Platform(name: "Xbox", imageName: "xbox.logo", color: .green), games: [
        Game(name: "Madden", rating: "89")
    ]
    
    )
}
