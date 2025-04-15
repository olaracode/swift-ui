//
//  FormUI.swift
//  test
//
//  Created by Octavio Lara on 14/04/2025.
//

import SwiftUI

struct InputField: View {
    let title: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.headline)
            TextField("Enter \(title.lowercased())", text: $text)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(12)
        }
    }
}

struct CustomPicker: View {
    let title: String
    @Binding var selection: String
    let options: [String]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.headline)
            Picker(title, selection: $selection) {
                ForEach(options, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding(8)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(12)
        }
    }
}

struct SegmentedPicker: View {
    let options: [String]
    let title: String
    @Binding var selection: String

    var body: some View {
        VStack(alignment: .leading){
            Text(title)
            HStack(spacing: 0) {
                ForEach(options, id: \.self) { option in
                    Button(action: {
                        withAnimation {
                            selection = option
                        }
                    }) {
                        Text(option)
                            .fontWeight(.medium)
                            .foregroundColor(selection == option ? .white : .black)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 10)
                            .background(
                                ZStack {
                                    if selection == option {
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color.green)
                                            .matchedGeometryEffect(id: "background", in: namespace)
                                    }
                                }
                            )
                    }
                }
            }
            .padding(4)
            .background(Color(.systemGray5))
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }

    @Namespace private var namespace
}
