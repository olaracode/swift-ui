//
//  PlantUIComponents.swift
//  test
//
//  Created by Octavio Lara on 10/04/2025.
//

import SwiftUI





struct AttributeView: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Text(label + ":")
                .fontWeight(.semibold)
            Spacer()
            Text(value)
                .foregroundColor(.secondary)
        }
    }
}

struct PlantStatusBadge: View {
    let status: PlantStatus
    
    var body: some View {
        ZStack {
            HStack {
                Circle()
                    .frame(width: 12, height: 12)
                    .foregroundColor(status.color)
                Text(status.label) // or "Need watering"
                    .font(.caption)
                    .foregroundColor(.white)
            }
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 4)
        .background(Color.black.opacity(0.4))
        .clipShape(Capsule())
        .padding(8)
        .bold()
    }
}


struct HomePlantCardView: View {
    let plant: PlantModel
    
    var body: some View{
        HStack {
           
            Image("philodendron")
                .resizable()
                .frame(width: 100, height: 120)
                .clipShape(RoundedRectangle(cornerRadius: 12))
               
            
            VStack(alignment: .leading) {
                
                Text(plant.name)
                    .font(.title)
                Text("Next water in ")
                    .font(.caption)
                Text("5 days")
                    .font(.caption)
                    .bold()
                HStack(alignment: .center) {
                  
                    Text(plant.status.label) // or "Need watering"
                        .font(.caption)
                    Circle()
                        .frame(width: 12, height: 12)
                        .foregroundColor(plant.status.color)
                }
            }

            Spacer()
        }
        .padding()
        .background()
        .cornerRadius(16)
        .shadow(radius: 0.8)
        .containerRelativeFrame(.horizontal)
    }
}
