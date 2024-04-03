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
    
    init(id: UUID, name: String, isDone: Bool, desc: String, steps: [[String]], images: String, startDate: Date, finalDate: Date, daysOfWeek: [Int], time: Date) {
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
        
        if date >= startDate && date < finalDate {
            print("Dentro")
            return true
        } else {
            print("Fora")
            return false
        }
    }
}
