//
//  Model.swift
//  MC04
//
//  Created by Laura C. Balbachan dos Santos on 27/03/24.
//

//  No Model fica toda a parte dos dados e lógica
//  O Model só se comunica com o View Model

import SwiftData
import Foundation
import SwiftData

struct HabitModel: Identifiable, Hashable {
    let id: UUID = UUID()
    var name: String
    var desc: String
    var steps: [[String]]
    var images: String
    
    func newHabits() -> Habits {
        return Habits(id: UUID(), name: self.name, isDone: false, desc: self.desc, steps: self.steps, images: self.images, startDate: Date(), finalDate: Date(), daysOfWeek: [], time: Date())
    }
}

@Model
class Habits: Identifiable {
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
