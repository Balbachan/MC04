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

@Model
class Habit {
    var name: String
    var desc: String
    var date: Date
    var isDone: Bool
    
    init(name: String, desc: String, date: Date, isDone: Bool) {
        self.name = name
        self.desc = desc
        self.date = date
        self.isDone = isDone
    }
}
