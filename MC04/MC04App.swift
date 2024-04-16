//
//  MC04App.swift
//  MC04
//
//  Created by Laura C. Balbachan dos Santos on 27/03/24.
//

import SwiftData
import SwiftUI

@main
struct MC04App: App {
    let container: ModelContainer
    
    init() {
        do {
            container = try ModelContainer(for: Habit.self)
        } catch {
            fatalError("Failed to create ModelContainer for Habit.")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(modelContext: container.mainContext)
        }
    }
}
