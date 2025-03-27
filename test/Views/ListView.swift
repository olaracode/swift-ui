//
//  ListView.swift
//  test
//
//  Created by Octavio Lara on 27/03/2025.
//

import SwiftUI

struct ListView: View {
    @State var items: [ItemModel] = [
        ItemModel(title: "First Todo", isCompleted: false),
        ItemModel(title: "Second Todo", isCompleted: true),
        ItemModel(title: "Third Todo", isCompleted: true),
    ]
    var body: some View {
        List {
            ForEach(items) { item in
                ListItemView(item: item)
            }
            .onDelete(perform: deleteItem)
            .onMove(perform: moveItem)
            
        }
        .navigationTitle("Todo List")
        .navigationBarItems(
            leading: EditButton(),
            trailing: NavigationLink("Add", destination: AddView())
        )
    }
    
    func deleteItem(indexSet: IndexSet) {
        items.remove(atOffsets: indexSet)
    }
    func moveItem(from: IndexSet, to: Int){
        items.move(fromOffsets: from, toOffset: to)
    }
}


#Preview {
    NavigationView {
        ListView()
    }
}
