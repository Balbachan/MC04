//
//  FuncModels.swift
//  MC04
//
//  Created by Igor Bragança Toledo on 16/04/24.
//

//import Foundation
//import SwiftUI
//
//struct FuncModels {
//    
//    @State private var weekCalendar = WeekModel()
//    
//    @State var sumDone = 0
//    @State var habits: [Habit]
//    
//    //Filtra os Habitos do dia
//    var filteredHabits: [Habit] {
//        return habits.filter { $0.verifyDateInterval(date: weekCalendar.selectedDate) }
//    }
//    
//    //Verifica se os hábitos do dia foram feitos
//    func verifyDone() {
//        var sumTotal = 0
//        for habit in filteredHabits where habit.isDone == true {
//            sumTotal += 1
//        }
//        sumDone = sumTotal
//    }
//}
