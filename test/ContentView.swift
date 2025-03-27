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
            Color(.gray)
                .ignoresSafeArea()
            VStack(alignment: .leading, spacing: 20.0) {
                Image("buenos-aires")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(15)
                
                HStack {
                    Text("Buenos Aires")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    // The spacer takes all the available space
                    // works to space elements between
                    Spacer()
                    VStack {
                        HStack {
                            Image(systemName: "star.fill")
                            Image(systemName: "star.fill")
                            Image(systemName: "star.fill")
                            Image(systemName: "star.fill")
                            Image(systemName: "star.leadinghalf.filled")
                        }
                        Text("(4.5/5)")
                            .foregroundColor(.black)
                    
                            .fontWeight(.bold)
                    }
                    .foregroundColor(.orange)
                    .font(.caption)


                }
                Text("Come visit the most beautiful port city on south america.")
                HStack {
                    Spacer()
                    Image(systemName: "binoculars.fill")
                    Image(systemName: "fork.knife")
                }
                .foregroundColor(.gray)
                .font(.caption)
                
            }
            .padding()
            .background(
                Rectangle()
                    .foregroundColor(.white)
                    .cornerRadius(15)
                    .shadow(radius: 15)
            )
            .padding()
            
        }
    }
}

#Preview {
    ContentView()
}
