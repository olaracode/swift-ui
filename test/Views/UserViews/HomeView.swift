//
//  HomeView.swift
//  test
//
//  Created by Octavio Lara on 13/04/2025.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var plantManager: PlantManager
    var body: some View {
        NavigationStack{
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    
                    // Header
                    Header()

                    // Featured Plant Image
                    Image("fiddle-leaf-fig")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(20)
                        .frame(height: 300)
                        .padding(.horizontal)

                    // My Plants Section
                    VStack(alignment: .leading, spacing: 8) {
                        Text("My Plants")
                            .font(.title2).bold()
                            .padding(.horizontal)

                        
                            if plantManager.plants.isEmpty {
                                Text("No plants, add a new one!")
                            } else {
                                ScrollView(.horizontal) {
                                    
                                    LazyHStack{
                                        ForEach(plantManager.plants){ plant in
                                            NavigationLink(destination: PlantDetails(plant: plant)){
                                                HomePlantCardView(plant: plant)
                                            }
                                            .buttonStyle(PlainButtonStyle())
                                           
                                              
                                        }
                                    }
                                    .scrollTargetLayout()
                                }
                                .contentMargins(.horizontal, 20)
                                .scrollTargetBehavior(.paging)
                            }
                        
                    }

                    // Tips & Tricks Section
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Tips & Tricks")
                            .font(.title2).bold()
                            .padding(.horizontal)

                        HStack {
                            Image("monsera-leaf")
                                .resizable()
                                .frame(width: 90, height: 90)
                                .clipShape(RoundedRectangle(cornerRadius: 12))

                            Text("Watering \n Guide")
                                .font(.title)
                            Spacer()
                        }
                        .padding()
                        .background(Color.green.opacity(0.2))
                        .cornerRadius(16)
                        .padding(.horizontal)
                    }
                }
                .padding(.top)
            }
            .background(Color(.systemGray6))
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(PlantManager())
}
