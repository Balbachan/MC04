//
//  MC04App.swift
//  MC04
//
//  Created by Laura C. Balbachan dos Santos on 27/03/24.
//

import SwiftData
import SwiftUI
import Aptabase

@main
struct MC04App: App {
    @AppStorage("teste") var teste: Bool = false
     let container: ModelContainer
    
    
    init() {
        do {
            container = try ModelContainer(for: Habit.self)
        } catch {
            fatalError("Failed to create ModelContainer for Habit.")
        }
        Aptabase.shared.initialize(appKey: "A-EU-9619857133") 
    }
   
    
    var body: some Scene {
        WindowGroup {
            ContentView(modelContext: container.mainContext)
                .onAppear(perform: {
                    Aptabase.shared.trackEvent("app_started") // Abriu o app
                    teste = true
                })
        }
    }
}
