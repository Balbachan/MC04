//
//  WeekModel.swift
//  MC04
//
//  Created by Igor Bragança Toledo on 28/03/24.
//

import Observation
import Foundation


@Observable
class WeekModel {
    private (set) var weeks: [Date]
    private (set) var currentDate: Date
    private (set) var selectedWeekIndex: Int
    
    var selectedDate: Date {
        didSet {
            calculateSelectedWeekIndex()
        }
    }
    
    
    init() {
        let today = Date()
        
        self.weeks = []
        self.currentDate = today
        self.selectedDate = today
        self.selectedWeekIndex = 0
        
        updateWeeks(date: self.currentDate)
        calculateSelectedWeekIndex()
    }
    
    private func calculateSelectedWeekIndex() {
        let weekOfYearSelectedDate = Calendar.current.component(.weekOfYear, from: selectedDate)
        let weekOfYearCurrentDate = Calendar.current.component(.weekOfYear, from: currentDate)
        self.selectedWeekIndex = (weeks.count / 2) + (weekOfYearSelectedDate - weekOfYearCurrentDate)
    }
    
    private func updateWeeks(date: Date) {
        let componentDay = DateComponents(weekday: 1)
        let calendar = Calendar.current
        var weeks:[Date] = []
        
        if let firstDayOfThisWeek = calendar.nextDate(after: date, matching: componentDay, matchingPolicy: .previousTimePreservingSmallerComponents, direction: .backward) {
            
            for i in -3...3 {
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
}
