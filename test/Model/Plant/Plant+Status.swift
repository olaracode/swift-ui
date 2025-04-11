//
//  Plant+Status.swift
//  test
//
//  Created by Octavio Lara on 09/04/2025.
//
import SwiftUI

enum PlantStatus: String, CaseIterable, Codable, Identifiable, Hashable {
    case healthy = "Healthy"
    case sick = "Sick"
    case inTreatment = "In Treatment"
    
    var id: String { rawValue }

    var label: String {
        switch self {
        case .healthy: return "Healthy"
        case .sick: return "Sick"
        case .inTreatment: return "In Treatment"
        }
    }

    var color: Color {
        switch self {
        case .healthy: return .green
        case .sick: return .red
        case .inTreatment: return .yellow
        }
    }
}
