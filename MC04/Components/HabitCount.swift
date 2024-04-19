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
    
    var body: some View {
        VStack(alignment: .center) {
            // Texto de feitos:
            if weekModel.sumDone == weekModel.filteredHabits().count {
                if weekModel.filteredHabits().count == 0 {
                    Text("\(weekModel.sumDone) Feitos")
                        .font(.custom("Digitalt", size: 24))
                        .foregroundColor(.appOrange)
                } else {
                    Text("\(weekModel.sumDone) Feitos")
                        .font(.custom("Digitalt", size: 24))
                        .foregroundColor(.green)
                }
            } else if weekModel.sumDone == 0 {
                Text("\(weekModel.sumDone) Feitos")
                    .font(.custom("Digitalt", size: 24))
                    .foregroundColor(.appOrange)
            } else {
                Text("\(weekModel.sumDone) Feitos")
                    .font(.custom("Digitalt", size: 24))
                    .foregroundColor(.appYellow)
            }
        }
    }
}
