//
//  Item.swift
//  Lab_7
//
//  Created by Deep Kaleka on 2025-07-29.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
