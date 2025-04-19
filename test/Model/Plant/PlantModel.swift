//
//  PlantModel.swift
//  test
//
//  Created by Octavio Lara on 08/04/2025.
//

import Foundation

struct PlantModel: Identifiable, Hashable, Codable {
    let id: String
    let name: String
    let light: String
    let weatherType: WeatherType
    let status: PlantStatus
    let location: PlantLocation
    let lastWatered: String?
    let nextWatering: Date?
    let wateringIntervalHours: Int
    let careNote: String?
    let user: String
    let notificationIdentifier: String?
    var needsWatering: Bool {
        guard let next = nextWatering else { return false }
        return Date() >= next
    }
    var hasNotification: Bool {
        return self.notificationIdentifier != nil
    }

}

