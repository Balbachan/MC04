//
//  PocView.swift
//  POC_SelfCare
//
//  Created by Igor Bragança Toledo on 26/03/24.
//

import Foundation
import SwiftUI
import SwiftData

struct CalendarView: View {
    @Environment(\.modelContext) var modelContext
    @Query var habits: [Habits]
    @State var isDone: Bool = false
    @State var date: Date = Date()
    @State private var path = [Habits]()
    @State private var weekCalendar = WeekModel()
    
//    var filteredHabits: [Habits] {
//        return habits.filter { $0.verifyDateInterval(date: weekCalendar.selectedDate) }
//    }
    
    var body: some View {
        NavigationStack(path: $path) {
            GeometryReader { geometry in
                VStack {
                    // Calendar
                    WeekScroll()
                        .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.2)
                    
                    // List
                    VStack {
                        List {
                            ForEach(habits) { habit in
                                NavigationLink(value: habit) {
                                    Text(habit.name)
                                    Text("\(habit.startDate)")
                                }
                            }
                            .onDelete(perform: deleteHabit)
                        }.listStyle(.plain)
                    }
                }
                .navigationTitle("Home")
                .navigationDestination(for: Habits.self, destination: EditTaskView.init)
                .toolbar {
                    Button("Add habit", systemImage: "plus", action: addHabit)
                }
            }
        }
    }
    
    // Acho que isso aqui deveria estar na ViewModel
    func addHabit() {
        modelContext.insert(Habits(id: UUID(), name: "eee", isDone: true, desc: "sdv", steps: "sdv", images: "sdv", startDate: weekCalendar.selectedDate, finalDate: Date(), daysOfWeek: [4], time: Date()))
    }
    
    func deleteHabit(_ indexSet: IndexSet) {
        for index in indexSet {
            let habit = habits[index]
            modelContext.delete(habit)
        }
    }
}


#Preview {
    CalendarView()
}
