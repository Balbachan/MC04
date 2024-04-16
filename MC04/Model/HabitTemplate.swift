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

struct HabitTemplate: Identifiable, Hashable {
    let id: UUID = UUID()
    var name: String
    var desc: String
    var steps: [[String]]
    var images: String
    
    func newHabits() -> Habit {
        return Habit(id: UUID(), name: self.name, isDone: false, desc: self.desc, steps: self.steps, images: self.images, startDate: Date(), finalDate: Date(), daysOfWeek: [], time: Date())
    }
}


