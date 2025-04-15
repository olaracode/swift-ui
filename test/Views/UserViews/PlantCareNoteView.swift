//
//  PlantCareNoteView.swift
//  test
//
//  Created by Octavio Lara on 14/04/2025.
//

import SwiftUI

struct PlantCareNoteView: View {
    /// Props
    var plant: PlantModel
    /// Environments
    @EnvironmentObject var plantManager: PlantManager
    @EnvironmentObject var authManager: AuthManager
    @Environment(\.dismiss) var dismiss
    
    /// State
    @State private var noteText: String = ""
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
              
                Text("\(noteText.isEmpty ? "Add" : "Update") Care Note")
                    .font(.largeTitle.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                // Text Area
                VStack(alignment: .leading, spacing: 8) {
                    Text("Care Note")
                        .font(.headline)

                    ZStack {
                        // Proper background behind the text
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(.secondarySystemBackground))

                        // Text editor with padding
                        TextEditor(text: $noteText)
                            .padding(8)
                            .foregroundColor(.primary)
                    }
                    .frame(height: 300)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                    )
                }
                
                
                // Save Button
                Button(action: {
                    Task {
                        await handleCareNote()
                        dismiss()

                    }
                }) {
                    Text("Save Note")
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(noteText.isEmpty ? Color.gray : Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .disabled(noteText.isEmpty)
                
                Spacer()
            }
            .padding()
            .navigationTitle(plant.name)
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            if let careNote = plant.careNote {
                noteText = careNote
            }
            
        }
    }
    
    func handleCareNote()async{
        do {
            if let token = authManager.token {
                try await plantManager.updateCareNote(
                    plantId: plant.id,
                    payload: CareNoteBody(careNote: noteText),
                    token: token
                )
            }
        }catch {
            print("Error saving care note: \(error.localizedDescription)")
        }
    }

}

#Preview {
    PlantCareNoteView(plant: Placeholders.plant)
}
