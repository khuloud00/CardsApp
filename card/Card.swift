//
//  Card.swift
//  card
//
//  Created by Asma Mohammed on 29/06/1446 AH.
//

import SwiftData
import Foundation

@Model
class Card {
    @Attribute(.unique) var id: UUID
    var text: String
    var category: String

    init(text: String, category: String) {
        self.id = UUID()
        self.text = text
        self.category = category
    }
}
