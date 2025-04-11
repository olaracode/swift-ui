import SwiftUI

struct AddPlantView: View {
    @EnvironmentObject var plants: PlantManager
    @EnvironmentObject var auth: AuthManager
    @Environment(\.dismiss) var dismiss

    @State private var name = ""
    @State private var lightLevel = "Low"
    @State private var location: PlantLocation = .indoor
    @State private var image: Image? = nil // You can hook up ImagePicker later
    @State private var weatherType: WeatherType = .humid
    @State private var status: PlantStatus = .healthy
    @State private var lastWatered: Date = Date()
    let lightLevels = ["Low", "Medium", "High"]
    
    var body: some View {
        NavigationView {
            VStack{
                Form {
                    Section(header: Text("Plant Info")) {
                        TextField("Plant name", text: $name)

                        Picker("Light level", selection: $lightLevel) {
                            ForEach(lightLevels, id: \.self) { level in
                                Text(level)
                            }
                        }

                        Picker("Location", selection: $location) {
                            ForEach(PlantLocation.allCases, id: \.self) { loc in
                                Text(loc.label).tag(loc)
                            }
                        }
                        
                        Picker("Weather Type", selection: $weatherType) {
                            ForEach(WeatherType.allCases, id: \.self) { weather in
                                Text(weather.label).tag(weather)
                            }
                        }
                        Picker("Status", selection: $status) {
                            ForEach(PlantStatus.allCases, id: \.self) { pickerStatus in
                                Text(pickerStatus.label).tag(pickerStatus)
                            }
                        }
                        DatePicker("Last watered", selection: $lastWatered)
                    }

                    Section {
                        Button("Save") {
                            Task {
                                try await createPlant()
                            }
                           
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
            }
            .navigationTitle("Add Plant")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    
    func createPlant() async throws {
        ///
        let newPlant = PlantBody(
            name: name,
            weatherType: weatherType.label,
            light: lightLevel,
            status: status.label,
            location: location.label,
            lastWatered: lastWatered.description
        )
        if let token = auth.token {
            try await plants.addPlant(payload: newPlant, token: token)
            clear()
            dismiss()
        }
    }
    func clear(){
        name = ""
        lightLevel = lightLevels[0]
        weatherType = WeatherType.mild
        status = PlantStatus.healthy
        location = PlantLocation.indoor
        lastWatered = Date()
    }
}
