//
//  CalendarHeader.swift
//  Dandie
//
//  Created by Laura C. Balbachan dos Santos on 22/04/24.
//

import SwiftUI

struct CalendarHeader: View {
    @EnvironmentObject private var weekModel: WeekModel
    @State var phrase: [String]
    
    var body: some View {
        HStack {
            Image("hidandie")
            
            // Texto de feitos
            if weekModel.sumDone == weekModel.filteredHabits().count {
                // Se não houver hábitos no dia
                if weekModel.filteredHabits().count == 0 {
                    Text(phrase[1])
                        .multilineTextAlignment(.leading)
                        .font(.custom(FontType.t1.font, size: 28))
                    
                    // Se todos foram concluídos
                } else {
                    Text(phrase[0])
                        .multilineTextAlignment(.leading)
                        .font(.custom(FontType.t1.font, size: 28))
                }
                
                // Se nenhum tiver sido concluído
            } else if weekModel.sumDone == 0 {
                Text(phrase[2])
                    .multilineTextAlignment(.leading)
                    .font(.custom(FontType.t1.font, size: 28))
                
                // Se pelo menos um for concluído
            } else {
                Text(phrase[1])
                    .multilineTextAlignment(.leading)
                    .font(.custom(FontType.t1.font, size: 28))
            }
            
            Spacer()
        }
    }
}

//#Preview {
//    CalendarHeader(phrase: ["Bora Reagir Meu Chapa"])
//}
