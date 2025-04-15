//
//  UIComponents.swift
//  test
//
//  Created by Octavio Lara on 13/04/2025.
//

import SwiftUI

struct Header: View {
    var body: some View {
        HStack {
            Text("Plant Care")
                .font(.largeTitle).bold()
            Spacer()
            NavigationLink(destination: CreatePlantView()) {
               Image(systemName: "plus")
                   .foregroundColor(.white)
                   .padding()
                   .background(Color.green)
                   .clipShape(Circle())
           }
        }
        .padding(.horizontal)
    }
}

//#Preview {
//    UIComponents()
//}
