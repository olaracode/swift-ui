//
//  Expense.swift
//  test
//
//  Created by Octavio Lara on 28/03/2025.
//

import Foundation
import SwiftData

@Model
class Expense {
    var name: String
    var date: Date
    var value: Double
    
    init(name: String, date: Date, value: Double) {
        self.name = name
        self.date = date
        self.value = value
    }
    
}
