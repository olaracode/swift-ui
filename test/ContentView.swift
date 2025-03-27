//
//  ContentView.swift
//  test
//
//  Created by Octavio Lara on 26/03/2025.
//

import SwiftUI

struct ContentView: View {
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
                    Image("card2")
                    Spacer()
                    Image("card3")
                    Spacer()
                }
                
                Spacer()
                Image("button")
                
                Spacer()
                
                HStack {
                    Spacer()

                    VStack(spacing: 20) {
                        Text("Player")
                            .font(.subheadline)
                        Text("0")
                            .font(.largeTitle)
                    }
                    
                    Spacer()

                    VStack(spacing: 20) {
                        Text("CPU")
                            .font(.subheadline)
                        
                        Text("0")
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
}

#Preview {
    ContentView()
}
