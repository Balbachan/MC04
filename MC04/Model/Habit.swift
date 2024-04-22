//
//  Habit.swift
//  MC04
//
//  Created by Igor Bragança Toledo on 16/04/24.
//

import Foundation
import SwiftData

@Model
class Habit: Identifiable {
    var id: UUID
    var name: String
    var isDone: Bool
    var desc: String
    var steps: [[String]]
    var images: String
    var startDate: Date
    var finalDate: Date
    var daysOfWeek: [Int]
    var time: Date
    
    init(id: UUID = UUID(), name: String = "", isDone: Bool = false, desc: String = "", steps: [[String]] = [], images: String = "", startDate: Date = Date(), finalDate: Date = Date(), daysOfWeek: [Int] = [], time: Date = Date()) {
        self.id = id
        self.name = name
        self.isDone = isDone
        self.desc = desc
        self.steps = steps
        self.images = images
        self.startDate = startDate
        self.finalDate = finalDate
        self.daysOfWeek = daysOfWeek
        self.time = time
    }
    
    func verifyDateInterval(date: Date) -> Bool {
        guard let auxDate = Calendar.current.date(byAdding: .day, value: 1, to: self.finalDate) else { return false }
        let finalDate = Calendar.current.startOfDay(for: auxDate)
        let startDate = Calendar.current.startOfDay(for: self.startDate)
        
        let dateWeekDay = Calendar.current.component(.weekday, from: date) // 3
        
        //Dentro do período
        if date >= startDate && date < finalDate {
            for day in daysOfWeek {
                if day == dateWeekDay {
                    return true
                }
            }
            return false
        } else { //Fora do período
            return false
        }
    }
}
