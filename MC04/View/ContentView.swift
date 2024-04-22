//
//  ContentView.swift
//  MC04
//
//  Created by Laura C. Balbachan dos Santos on 27/03/24.
//

import SwiftData
import SwiftUI
import UserNotifications

struct ContentView: View {
    @State private var weekModel: WeekModel
    
    init(modelContext: ModelContext) {
        let weekModel = WeekModel(modelContext: modelContext)
        _weekModel = State(initialValue: weekModel)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                CalendarView()
            }.onAppear{
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        print("Permission approved!")
                    } else if let error = error {
                        print(error.localizedDescription)
                    }
                }
            }
        }
        .environmentObject(weekModel)
    }
}

#Preview {
    ContentView(modelContext: try! ModelContainer(for: Habit.self).mainContext)
}
