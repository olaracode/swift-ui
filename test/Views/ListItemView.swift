//
//  ListItemView.swift
//  test
//
//  Created by Octavio Lara on 27/03/2025.
//

import SwiftUI

struct ListItemView: View {
    let item: ItemModel
    var body: some View {
        HStack{
            Image(systemName: item.isCompleted ? "checkmark.circle" : "circle")
                .foregroundColor(item.isCompleted ? .green : .red)
            Text(item.title)
            Spacer()
        }
        .font(.title2)
        .padding(.vertical, 8)
    }
}

#Preview {
   
    Group{
        ListItemView(item: ItemModel(title: "Some test", isCompleted: false))
        ListItemView(item: ItemModel(title: "Some test", isCompleted: true))
    }
}
