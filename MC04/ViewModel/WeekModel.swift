//
//  WeekModel.swift
//  MC04
//
//  Created by Igor Bragança Toledo on 28/03/24.
//

import Foundation
import Observation

@Observable
class WeekModel {
    private (set) var weeks: [Date]
    private (set) var currentDate: Date
    private (set) var selectedWeek: Int
    
    var selectedDate: Date {
        didSet {
            calculateSelectedWeek()
        }
    }
    
    init(weeks: [Date], currentDate: Date, selectedWeek: Int, selectedDate: Date) {
        let today = Date()
        
        self.weeks = []
        self.currentDate = today
        self.selectedWeek = 0
        self.selectedDate = today
    }
    
    private func calculateSelectedWeek() {
        let weekOfYearSelectedDate = Calendar.current.component(.weekOfYear, from: selectedDate)
        let weekOfYearCurrentDate = Calendar.current.component(.weekOfYear, from: currentDate)
        
        self.selectedWeek = (weeks.count / 2) + (weekOfYearSelectedDate - weekOfYearCurrentDate)
    }
    
    private func updateWeeks(date: Date){
        let componentDay = DateComponents(weekday: 1)
        let calendar = Calendar.current
        var weeks:[Date] = []
        
        if let firstDayOfThisWeek = calendar.nextDate(after: date, matching: componentDay, matchingPolicy: .previousTimePreservingSmallerComponents, direction: .backward) {
            
            for i in -500 ... 500 {
                if let newDate = calendar.date(byAdding: .weekOfYear, value: i, to: firstDayOfThisWeek) {
                    weeks.append(newDate)
                } else {
                    print("Problemas em calcular a semana")
                    return
                }
            } 
            self.weeks = weeks
        } else {
            print("problema em calcular o primeiro dia da semana")
        }
    }
}

