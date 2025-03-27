//
//  ListView.swift
//  test
//
//  Created by Octavio Lara on 27/03/2025.
//

import SwiftUI

struct ListView: View {
    @EnvironmentObject var listViewModel: ListViewModel
 
    var body: some View {
        List {
            ForEach(listViewModel.items) { item in
                ListItemView(item: item)
                    .onTapGesture {
                        withAnimation(.linear) {
                            listViewModel.updateItem(item: item)
                        }
                    }
            }
            .onDelete(perform: listViewModel.deleteItem)
            .onMove(perform: listViewModel.moveItem)
            
        }
        .navigationTitle("Todo List")
        .navigationBarItems(
            leading: EditButton(),
            trailing: NavigationLink("Add", destination: AddView())
        )
    }
}


#Preview {
    NavigationView {
        ListView()
    }
    .environmentObject(ListViewModel())
}
