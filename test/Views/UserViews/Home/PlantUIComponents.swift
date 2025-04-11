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
        Text(status.label)
            .font(.caption)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(status.color.opacity(0.8))
            .foregroundColor(.white)
            .cornerRadius(8)
    }
}
