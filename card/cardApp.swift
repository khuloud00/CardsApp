//
//  cardApp.swift
//  card
//
//  Created by khuloud nasser on 14/06/1446 AH.
//
import SwiftUI
import SwiftData

@main
struct CardsApp: App {
    var body: some Scene {
        WindowGroup {
            InstantCardView()
                .modelContainer(for: [Card.self]) // Register your models
        }
    }
}
