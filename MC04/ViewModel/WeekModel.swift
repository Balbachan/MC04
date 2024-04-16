//
//  WeekModel.swift
//  MC04
//
//  Created by Igor Bragança Toledo on 28/03/24.
//

import Observation
import Foundation
import SwiftData


class WeekModel: ObservableObject {
    @Published private (set) var weeks: [Date]
    @Published private (set) var currentDate: Date
    @Published private (set) var selectedWeekIndex: Int
    @Published private var modelContext: ModelContext
    @Published var habits: [Habit] = []
    
    var selectedDate: Date {
        didSet {
            calculateSelectedWeekIndex()
        }
    }
    
    init(modelContext: ModelContext) {
        let today = Date()
        
        self.weeks = []
        self.currentDate = today
        self.selectedDate = today
        self.selectedWeekIndex = 0
        self.modelContext = modelContext

        Task {
            await MainActor.run {
                fetchData()
                updateWeeks(date: self.currentDate)
                calculateSelectedWeekIndex()
            }
        }
    }
    
    @MainActor
    func fetchData() {
        do {
            let descriptor = FetchDescriptor<Habit>()
            habits = try modelContext.fetch(descriptor)
        } catch {
            print("Fetch failed")
        }
    }
    
    func addHabit(_ habit: Habit) {
        modelContext.insert(habit)
        Task {
            await MainActor.run {
                fetchData()
            }
        }
    }
    
    func deleteHabit(_ habit: Habit) {
        modelContext.delete(habit)
        Task {
            await MainActor.run {
                fetchData()
            }
        }
    }
    
    private func calculateSelectedWeekIndex() {
        let weekOfYearSelectedDate = Calendar.current.component(.weekOfYear, from: selectedDate)
        let weekOfYearCurrentDate = Calendar.current.component(.weekOfYear, from: currentDate)
        self.selectedWeekIndex = (weeks.count / 2) + (weekOfYearSelectedDate - weekOfYearCurrentDate)
    }
    
    @MainActor
    private func updateWeeks(date: Date) {
        let componentDay = DateComponents(weekday: 1)
        let calendar = Calendar.current
        var weeks:[Date] = []
        
        if let firstDayOfThisWeek = calendar.nextDate(after: date, matching: componentDay, matchingPolicy: .previousTimePreservingSmallerComponents, direction: .backward) {
            
            for i in -10...10 {
                if let newDate = calendar.date(byAdding: .weekOfYear, value: i, to: firstDayOfThisWeek) {
                    weeks.append(newDate)
                } else {
                    print("problema em calcular semana")
                    return
                }
            }
            self.weeks = weeks
        } else {
            print("problema em calcular o primeiro dia da semana")
        }
    }
    
    
    func filteredHabits() -> [Habit] {
        return habits.filter { $0.verifyDateInterval(date: selectedDate) }
    }
}
