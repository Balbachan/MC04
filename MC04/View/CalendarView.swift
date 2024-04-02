//
//  PocView.swift
//  POC_SelfCare
//
//  Created by Igor Bragança Toledo on 26/03/24.
//

import Foundation
import SwiftUI
import SwiftData

struct CalendarView: View {
    @Environment(\.modelContext) var modelContext
    @Query var habits: [Habits]
    @State private var weekCalendar = WeekModel(weeks: [], currentDate: Date(), selectedWeek: 0, selectedDate: Date())
    
    var filteredHabits: [Habits] {
        return habits.filter { $0.verifyDateInterval(date: weekCalendar.selectedDate) }
    }
    
    var body: some View {
        NavigationView{
            GeometryReader{ geometry in
                VStack{
                    // Calendar
                    WeekScroll(weekModel: $weekCalendar)
                        .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.2)
                    
                    // List
                    List(filteredHabits) { habit in
                        HStack {
                            Text(habit.name)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    .listStyle(.plain)
                }
                .navigationTitle("POC")
                .toolbar {
                    Button("Add habit", systemImage: "plus", action: addHabit)
                }
            }
        }
    }
    
    // Acho que isso aqui deveria estar na ViewModel
    func addHabit() {
        modelContext.insert(Habits(id: UUID(), name: "eee", isDone: true, desc: "sdv", steps: "sdv", images: "sdv", startDate: weekCalendar.selectedDate, finalDate: Date(), daysOfWeek: [4], time: Date()))
    }
    
    //Arrumar o bug (Igor)
    
    // selecionar as datas (daysOfWeek) -> Verificar dias da semana (Igor)
    
    // deletar hábitos registrados (Laura)
    
    // editar hábitos registrados (Laura)
    
    // Fazer checklist (Laura)
    
}


#Preview {
    CalendarView()
}
