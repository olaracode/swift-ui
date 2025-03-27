//
//  ItemModel.swift
//  test
//
//  Created by Octavio Lara on 27/03/2025.
//

import Foundation

struct ItemModel: Identifiable {
    let id = UUID()
    let title: String
    let isCompleted: Bool
}
