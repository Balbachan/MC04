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
            
            // Texto de feitos
            if weekModel.sumDone == weekModel.filteredHabits().count {
                // Se não houver hábitos no dia
                if weekModel.filteredHabits().count == 0 {
                    Text("\(weekModel.sumDone)/\(weekModel.filteredHabits().count) Feitos")
                        .font(.custom("Digitalt", size: 24))
                        .foregroundColor(.appDarkGray)
                    
                // Se todos foram concluídos
                } else {
                    Text("\(weekModel.sumDone)/\(weekModel.filteredHabits().count) Feitos")
                        .font(.custom("Digitalt", size: 24))
                        .foregroundColor(.appOrange)
                }
                
                // Se nenhum tiver sido concluído
            } else if weekModel.sumDone == 0 {
                Text("\(weekModel.sumDone)/\(weekModel.filteredHabits().count) Feitos")
                    .font(.custom("Digitalt", size: 24))
                    .foregroundColor(.appDarkGray)
                
                // Se pelo menos um for concluído
            } else {
                Text("\(weekModel.sumDone)/\(weekModel.filteredHabits().count) Feitos")
                    .font(.custom("Digitalt", size: 24))
                    .foregroundColor(.appYellow)
            }
        }
        .foregroundStyle(.clear)
    }
}
