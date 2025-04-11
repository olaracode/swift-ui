//
//  Plant+Cast.swift
//  test
//
//  Created by Octavio Lara on 09/04/2025.
//

import Foundation

/// Initialization | Cast PlantResponse -> PlantModel
extension PlantModel {
    init(from response: PlantResponse){
        /// Date formater initialization
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

        self.id = response._id
        self.name = response.name
        
        self.light = response.light
       
        /// Creates a relative date from a Stringified Date
        /// response.lastWatered: 2024-12-30T16:01:10.000Z
        /// output: "2 Hours ago" | "One week ago" | etc
        if let date = formatter.date(from: response.lastWatered){
            let relativeFormatter = RelativeDateTimeFormatter()
            relativeFormatter.unitsStyle = .full // .short
            self.lastWatered = relativeFormatter.localizedString(for: date, relativeTo: Date())
        } else {
            self.lastWatered = nil
        }
        
        /// Enums
        self.status = PlantStatus(rawValue: response.status) ?? .healthy
        self.location = PlantLocation(rawValue: response.location) ?? .indoor
        self.weatherType = WeatherType(rawValue: response.weatherType) ?? .humid

        /// Relation
        self.user = response.user
    }
}

