//
//  ListStyle.swift
//  MC04
//
//  Created by Laura C. Balbachan dos Santos on 03/04/24.
//

import SwiftUI
import SwiftData

struct ListRowStyle: View {
    var habit: Habits
    
    var body: some View {
        HStack {
            Image(habit.isDone ? "checkBoxOn" : "checkBoxOff")
                .onTapGesture {
                    habit.isDone.toggle()
                }
                .padding(.trailing, 20)
            
            Text("\(habit.name)")
                .font(.custom("Digitalt", size: 32))
            
            
        }
        .padding()
        .padding(.horizontal, 60)
        .background(.gray)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Habits.self, configurations: config)
        let example = Habits(id: UUID(), name: "Lavar o rosto", isDone: true, desc: "Indicado de manhã e a noite.Passo essencial para limpar a pele, serve para remover a oleosidade e impurezas.Não esqueça de escolher um sabonete adequado para seu tipo de pele.", steps: [["1","Lave suas mãos", "Antes de começar a lavar o rosto lave suas mãos. Assim você não vai contagiar seu rosto com possíveis bacterias."],["2", "Use água morna", "Cuidado com a temperatura da água sempre tente lavar o rosto com uma água que esteja morna. Água muito quente pode causar danos a pele."]], images: "sdv", startDate: Date(), finalDate: Date(), daysOfWeek: [1], time: Date())
        return ListRowStyle(habit: example)
            .modelContainer(container)
    } catch {
        fatalError("Alguém me desconfigurou")
    }
}
