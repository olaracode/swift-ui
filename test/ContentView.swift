//
//  ContentView.swift
//  test
//
//  Created by Octavio Lara on 26/03/2025.
//

import SwiftUI

struct ContentView: View {
    // User states
    @State var playerCard = "card7"
    @State var playerScore = 0
    
    // CPU States
    @State var cpuCard = "card13"
    @State var cpuScore = 0
    
    var body: some View {
        ZStack{
            Image("background-plain")
                .ignoresSafeArea()
                
            VStack {
                Spacer()
                Spacer()
                
                Image("logo")
                Spacer()
                
                HStack {
                    Spacer()
                    Image(playerCard)
                    Spacer()
                    Image(cpuCard)
                    Spacer()
                }
                
                Spacer()
                Button {
                    deal()
                } label: {
                    Image("button")
                }
                
                Spacer()
                
                HStack {
                    Spacer()

                    VStack(spacing: 20) {
                        Text("Player")
                            .font(.headline)
                        Text(String(playerScore))
                            .font(.largeTitle)
                    }
                    
                    Spacer()

                    VStack(spacing: 20) {
                        Text("CPU")
                            .font(.headline)
                        
                        Text(String(cpuScore))
                            .font(.largeTitle)
                    }
                    Spacer()

                }
                .foregroundColor(.white)
                
                Spacer()
                Spacer()
            }
            .padding()
        }
      
    }


    func deal(){
        // generate random values
        let playerValue = Int.random(in:2...14)
        let cpuValue = Int.random(in:2...14)
        
        // update states
        playerCard = "card" + String(playerValue)
        cpuCard = "card" + String(cpuValue)
        
        // update the scores
        if playerValue > cpuValue {
            
            // add 1 to player score
            playerScore += 1
        }
        else if cpuValue > playerValue {
            // add 1 to cpu score
            cpuScore += 1
        } else {
            // tie
        }
    }
}

#Preview {
    ContentView()
}
