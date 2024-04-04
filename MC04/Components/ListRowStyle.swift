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
        let example = Habits(id: UUID(), name: "hoje", isDone: false, desc: "sdv", steps: "sdv", images: "sdv", startDate: Date(), finalDate: Date(), daysOfWeek: [1], time: Date())
        return ListRowStyle(habit: example)
            .modelContainer(container)
    } catch {
        fatalError("Alguém me desconfigurou")
    }
}
