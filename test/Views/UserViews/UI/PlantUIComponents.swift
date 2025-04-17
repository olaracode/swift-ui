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
        ZStack {
            HStack {
                Circle()
                    .frame(width: 12, height: 12)
                    .foregroundColor(status.color)
                Text(status.label) // or "Need watering"
                    .font(.caption)
                    .foregroundColor(.white)
            }
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 4)
        .background(Color.black.opacity(0.4))
        .clipShape(Capsule())
        .padding(8)
        .bold()
    }
}


struct CountdownView: View {
    let targetDate: Date
    @State private var now = Date()
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        Text(displayText)
            .fontWeight(.light)
            .onReceive(timer) { _ in
                now = Date()
            }
    }

    var displayText: String {
        let diff = targetDate.timeIntervalSince(now)
        
        if diff > 24 * 60 * 60 {
            // More than 24 hours: show formatted date
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            return formatter.string(from: targetDate)
        } else if diff > 0 {
            // Less than 24 hours: show countdown
            let hours = Int(diff) / 3600
            let minutes = (Int(diff) % 3600) / 60
            let seconds = Int(diff) % 60
            return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        } else {
            return "Time's up!"
        }
    }
}

struct PlantCareNote: View {
    var plant: PlantModel
    var body: some View {
        NavigationLink(destination: PlantCareNoteView(plant: plant)) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Care Notes")
                    .font(.headline)

                if plant.careNote == nil {
                    Text("No care note defined")
                        .foregroundColor(.gray)
                } else {
                    Text(plant.careNote ?? "")
                        .foregroundColor(.secondary)
                }
            }
            .padding(.horizontal)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

