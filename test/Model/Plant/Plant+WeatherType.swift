//
//  Plant+WeatherType.swift
//  test
//
//  Created by Octavio Lara on 09/04/2025.
//

import Foundation
import SwiftUI

enum WeatherType: String, CaseIterable, Codable, Identifiable, Hashable {
    case dry = "Dry"
    case humid = "Humid"
    case hot = "Hot"
    case cold = "Cold"
    case mild = "Mild"
    case tropical = "Tropical"
    case arid = "Arid"
    
    var id: String { rawValue }

    var label: String {
        switch self {
        case .dry: return "Dry"
        case .humid: return "Humid"
        case .hot: return "Hot"
        case .cold: return "Cold"
        case .mild: return "Mild"
        case .tropical: return "Tropical"
        case .arid: return "Arid"
        }
    }

    var icon: String {
        switch self {
        case .dry: return "drop.degreesign.slash"        // Dry
        case .humid: return "humidity"                    // Humid
        case .hot: return "thermometer.sun"               // Hot
        case .cold: return "snowflake"                    // Cold
        case .mild: return "thermometer.medium"           // Mild
        case .tropical: return "sun.max.trianglebadge.exclamationmark" // Tropical
        case .arid: return "sun.dust"                     // Arid
        }
    }

    var color: Color {
        switch self {
        case .dry: return .brown
        case .humid: return .blue
        case .hot: return .red
        case .cold: return .cyan
        case .mild: return .orange
        case .tropical: return .green
        case .arid: return .yellow
        }
    }
}
