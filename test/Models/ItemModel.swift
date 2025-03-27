//
//  ItemModel.swift
//  test
//
//  Created by Octavio Lara on 27/03/2025.
//

import Foundation


// Immutable Struct
struct ItemModel: Identifiable {
    let id: String
    let title: String
    let isCompleted: Bool
    init(title: String, isCompleted: Bool, id: String = UUID().uuidString){
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
    }
    
    func updateCompletion() -> ItemModel {
        return ItemModel(
            title: self.title,
            isCompleted: !self.isCompleted,
            id: self.id
        )
    }
}
