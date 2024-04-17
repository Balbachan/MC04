//
//  HabitCount.swift
//  Dandie
//
//  Created by Igor Bragança Toledo on 16/04/24.
//

import Foundation
import SwiftUI

struct HabitCountView: View {
    @EnvironmentObject private var weekModel: WeekModel
    
    private var filteredHabits: [Habit] {
        return weekModel.filteredHabits()
    }
    
    private var sumDone: Int {
        var sumTotal = 0
        let filteredHabits = weekModel.filteredHabits()
        
        for habit in filteredHabits where habit.isDone == true {
            sumTotal += 1
        }
        return sumTotal
    }
    
    var body: some View {
        // Texto de feitos:
        if sumDone == filteredHabits.count {
            if filteredHabits.count == 0 {
                Text("\(sumDone) Feitos")
                    .font(.custom("Digitalt", size: 24))
                    .foregroundColor(.appOrange)
            } else {
                Text("\(sumDone) Feitos")
                    .font(.custom("Digitalt", size: 24))
                    .foregroundColor(.green)
            }
        } else if sumDone == 0 {
            Text("\(sumDone) Feitos")
                .font(.custom("Digitalt", size: 24))
                .foregroundColor(.appOrange)
        } else {
            Text("\(sumDone) Feitos")
                .font(.custom("Digitalt", size: 24))
                .foregroundColor(.appYellow)
        }
    }
}
