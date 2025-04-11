//
//  PlantModel.swift
//  test
//
//  Created by Octavio Lara on 08/04/2025.
//

import Foundation
import SwiftUI

enum PlantStatus: String, CaseIterable, Codable, Identifiable {
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

struct PlantModel: Identifiable {
    let id: String
    let name: String
    let light: String
    let weatherType: String
    let status: PlantStatus
    let location: String
    let lastWatered: String?
    let user: String
  
}
extension PlantModel {
    init(from response: PlantResponse){
        
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

        self.id = response._id
        self.name = response.name
        self.weatherType = response.weatherType
        self.light = response.light
        
        if let date = formatter.date(from: response.lastWatered){
            let relativeFormatter = RelativeDateTimeFormatter()
            relativeFormatter.unitsStyle = .full // .short
            self.lastWatered = relativeFormatter.localizedString(for: date, relativeTo: Date())
        } else {
            self.lastWatered = nil
        }
        self.status = PlantStatus(rawValue: response.status) ?? .healthy
        self.location = response.location
        
        self.user = response.user
    }
}


