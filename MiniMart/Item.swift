//
//  Item.swift
//  MiniMart
//
//  Created by Mouni on 5/13/26.
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
