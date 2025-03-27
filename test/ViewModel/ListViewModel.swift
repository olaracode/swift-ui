//
//  ListViewModel.swift
//  test
//
//  Created by Octavio Lara on 27/03/2025.
//

import Foundation

class ListViewModel: ObservableObject {
    @Published var items: [ItemModel] = [];
    
    init(){
        getItems()
    }
    
    func getItems(){
        let newItems =  [
            ItemModel(title: "First Todo", isCompleted: false),
            ItemModel(title: "Second Todo", isCompleted: true),
            ItemModel(title: "Third Todo", isCompleted: true)
        ]
        items.append(contentsOf: newItems)
        
    }
    
    func deleteItem(indexSet: IndexSet) {
        items.remove(atOffsets: indexSet)
    }
    
    func moveItem(from: IndexSet, to: Int){
        items.move(fromOffsets: from, toOffset: to)
    }
    
    func addItem(title: String) {
        let newItem = ItemModel(title: title, isCompleted: false)
        items.append(newItem)
    }
    
    func updateItem(item: ItemModel){
//        if let index = items.firstIndex { (existingItem) -> Bool in
//            return existingItem.id == item.id
//        } {
//            // run this code
//        }
        
        if let index = items.firstIndex(where: {$0.id == item.id }){
            items[index] = item.updateCompletion()
        }
    }
}

