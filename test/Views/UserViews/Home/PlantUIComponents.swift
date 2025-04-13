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


