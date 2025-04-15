//
//  CreatePlantView.swift
//  test
//
//  Created by Octavio Lara on 14/04/2025.
//

import SwiftUI

struct CreatePlantView: View {
    @EnvironmentObject var plantManager: PlantManager
    @EnvironmentObject var authManager: AuthManager
    @State private var name = ""
    @State private var weatherType = WeatherType.arid.label
    @State private var light = "Indirect"
    @State private var status = PlantStatus.healthy.label
    @State private var location = PlantLocation.indoor.label
    @State private var lastWatered = Date()
    @State private var wateringIntervalHours = 24
    
    @Environment(\.dismiss) var dismiss

    let weatherOptions = WeatherType.allCases.map(\.label)
    let locationOptions = PlantLocation.allCases.map(\.label)
    let lightOptions = ["Indirect", "Direct", "Low Light"]
    let statusOptions = PlantStatus.allCases.map(\.label)
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    
                    // Title
                    Text("Add New Plant")
                        .font(.largeTitle).bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)

                    // Form Inputs
                    Group {
                        InputField(title: "Name", text: $name)
                        CustomPicker(title: "Weather", selection: $weatherType, options: weatherOptions)
                        
                        SegmentedPicker(options: locationOptions, title: "Location", selection: $location)
                        
                        SegmentedPicker(options: lightOptions, title: "Light", selection: $light)
                        SegmentedPicker( options: statusOptions, title: "Status", selection: $status)
                       


                        HStack(spacing: 4) {
                            Text("Last Watered")
                                .font(.headline)
                            Spacer()
                            DatePicker("", selection: $lastWatered, displayedComponents: .date)
                                .labelsHidden()
                        }
//                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(12)

                        VStack(alignment: .leading, spacing: 4) {
                            Text("Watering Interval (Hours)")
                                .font(.headline)
                            Stepper(value: $wateringIntervalHours, in: 6...168, step: 6) {
                                Text("\(wateringIntervalHours) hrs")
                            }
                        }
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(12)
                    }
                    .padding(.horizontal)

                    // Save Button
                    Button(action: {
                        Task {
                            await createPlant()
                            dismiss()
                        }
                       
                    }) {
                        Text("Save Plant")
                            .bold()
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    .padding(.horizontal)
                }
                .padding(.top)
            }
            .navigationTitle("New Plant")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    func createPlant() async {
        let newPlant = PlantBody(
            name: name,
            weatherType: weatherType,
            light: light,
            status: status,
            location: location,
            lastWatered: lastWatered.description,
            wateringIntervalHours: wateringIntervalHours
        )
        do {
            if let token = authManager.token {
                try await plantManager.addPlant(payload: newPlant, token: token)
            }
        } catch {
            print("Error \(error)")
        }
        
    }
}




#Preview {
    CreatePlantView()
}
