//
//  Date+DMY.swift
//  test
//
//  Created by Octavio Lara on 07/04/2025.
//

import Foundation

extension Date{
    func formattedAsDMY() -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd - MM - yy" // ⚠️ lowercase `dd` and `yy`
            return formatter.string(from: self)
    }
}
