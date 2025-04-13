//
//  Playground.swift
//  test
//
//  Created by Octavio Lara on 11/04/2025.
//

import SwiftUI

struct Playground: View {
    @State var isShown = false
    @Namespace var animation
    var body: some View {
        ZStack {
            if isShown {
                ZStack {
                    LinearGradient(
                        gradient: Gradient(colors: [Color.green.opacity(0.2), .white]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .matchedGeometryEffect(id: "circle", in: animation)
                    .ignoresSafeArea()
                       
                    VStack(alignment: .leading) {
                        ZStack(alignment: .topLeading) {
                            Image("plant-pot") // Replace with actual image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .matchedGeometryEffect(id: "-image", in: animation,  isSource: true)
                                .frame(height: 240)
                                .frame(width: .infinity)
                                .clipped()
                                .cornerRadius(0)
                                .ignoresSafeArea()
                            Button("Back") {
                                withAnimation {
                                    isShown.toggle()
                                }
                            }
                            .padding()
                       
                        }
                        
                        VStack {
                            Text("Hey")
                                .matchedGeometryEffect(id: "text", in: animation)
                                .foregroundColor(.black)
                                .font(.title)
                            Spacer()
                        }
                        .padding()
                        
                    }
      
                   
                }
            } else {
                ZStack {
                    LinearGradient(
                        gradient: Gradient(colors: [Color.green.opacity(0.2), .white]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .matchedGeometryEffect(id: "circle", in: animation)
                    .frame(width: .infinity)
                    .cornerRadius(20)
                    .shadow(radius: 10)
                    
                       
                       
                    ZStack {
                        ZStack(alignment: .topLeading) {
                            Image("plant-pot") // Replace with actual image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .matchedGeometryEffect(id: "-image", in: animation,  isSource: true)
                                .frame(height: .infinity)
                                .clipped()
                                .cornerRadius(20)
                                .overlay(
                                    LinearGradient(
                                        gradient: Gradient(colors: [
                                            Color.clear,
                                            Color.clear,
                                            Color.black.opacity(0.60)
                                        ]),
                                        startPoint: .top,
                                        endPoint: .bottom
                                    )
                                    .cornerRadius(20)
                                )
                            ZStack {
                                HStack {
                                    Circle()
                                        .frame(width: 12, height: 12)
                                        .foregroundColor(.red)
                                    Text("Something") // or "Need watering"
                                        .font(.caption)
                                        .foregroundColor(.white)
                                }
                            }
                            .padding(.horizontal, 10)
                            .padding(.vertical, 4)
                            .clipShape(Capsule())
                            .padding(8)
                            .bold()
                           
                        }
                        VStack(alignment: .trailing){
                            Spacer()
                            HStack(alignment: .center) {
                                Text("Hey")
                                    .matchedGeometryEffect(id: "text", in: animation)

                                    .foregroundColor(.white)
                                    .font(.title)
                                Text("Watered")
                                    .foregroundColor(.white)
                                    .font(.caption)
                                Spacer()
                            }
                           
                        }
                        .padding()
                        
                    }
                    .padding(2)
                    .onTapGesture {
                        withAnimation {
                            isShown.toggle()
                        }
                        
                    }
                    
                }
                .frame(width: 300, height: 240)

            }
        }
        .background(.white)
       
    }

}

#Preview {
        Playground()
}
