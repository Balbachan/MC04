//
//  ViewModel.swift
//  MC04
//
//  Created by Laura C. Balbachan dos Santos on 27/03/24.
//

// Aqui é onde a comunicação entre as Views e o Model é feito, além de ser onde os dados são alterados

import Foundation

var habits: [Habits] = [
    Habits(id: UUID(), name: "hoje", isDone: true, desc: "sdv", steps: "sdv", images: "sdv", startDate: Date(), finalDate: Date(), daysOfWeek: [1], time: Date()),
    Habits(id: UUID(), name: "futuro", isDone: true, desc: "sdv", steps: "sdv", images: "sdv", startDate: Calendar.current.date(byAdding: .day, value: 0, to: Date())!, finalDate: Calendar.current.date(byAdding: .day, value: 4, to: Date())!, daysOfWeek: [1], time: Date())
]

