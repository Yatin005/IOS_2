//
//  Item.swift
//  lab_9_Image
//
//  Created by Deep Kaleka on 2025-07-17.
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
