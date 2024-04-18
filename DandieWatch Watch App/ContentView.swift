//
//  ContentView.swift
//  DandieWatch Watch App
//
//  Created by Beatriz Andreucci on 11/04/24.
//

import SwiftUI
//import SwiftData

struct ContentView: View {
//    @State private var weekModel: WeekModel
//    
//    init(modelContext: ModelContext) {
//        let weekModel = WeekModel(modelContext: modelContext)
//        _weekModel = State(initialValue: weekModel)
//    }
    
    var body: some View {
        CalendarWatch(phrases: ["aaa"])
            .environmentObject(weekModel)
//        Text("w")
    }
}

//#Preview {
//    ContentView(modelContext: try! ModelContainer(for: Habit.self).mainContext)
//}
