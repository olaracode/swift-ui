//
//  ContentView.swift
//  test
//
//  Created by Octavio Lara on 26/03/2025.
//

import SwiftUI

struct ContentView: View {
    
    var playerCard = "card7"
    var playerScore = 0
    
    var cpuCard = "card13"
    var cpuScore = 0
    
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
        print("deal")
    }
}

#Preview {
    ContentView()
}
