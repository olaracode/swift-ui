//
//  Consts.swift
//  test
//
//  Created by Octavio Lara on 05/04/2025.
//

import Foundation

struct AppMetadata {
    static let title = "Botania"
    static let logo = "some-logo"
}


struct Placeholders {
    static let plant: PlantModel = PlantModel(
        id: "1234",
        name: "Putica",
        light: "Mucha",
        weatherType: .dry,
        status: .inTreatment,
        location: .indoor,
        lastWatered: "Two hours ago",
        nextWatering: Date.now,
        wateringIntervalHours: 24,
        careNote: "Care note testa",
        user: "123123123",
        notificationIdentifier: nil
    )
}
