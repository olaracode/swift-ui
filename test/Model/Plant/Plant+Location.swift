//
//  Plant+Location.swift
//  test
//
//  Created by Octavio Lara on 09/04/2025.
//

import Foundation
import SwiftUI
enum PlantLocation: String, CaseIterable, Identifiable, Codable, Hashable {
    case indoor = "Indoor"
    case outdoor = "Outdoor"
    
    var id: String { rawValue }
    
    var label: String {
        switch self {
        case .indoor: return "Indoor"
        case .outdoor: return "Outdoor"
        }
    }
    
    var icon: String {
        switch self {
        case .indoor: return "house"
        case .outdoor: return "tree"
        }
    }
    
    var color: Color {
        switch self {
        case .indoor:
            return Color.blue.opacity(0.7) // calming and associated with inside
        case .outdoor:
            return Color.green.opacity(0.7) // nature / outdoor vibes
        }
    }
}
