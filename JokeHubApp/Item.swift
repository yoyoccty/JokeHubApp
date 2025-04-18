//
//  Item.swift
//  JokeHubApp
//
//  Created by 刘兆举 on 4/18/25.
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
