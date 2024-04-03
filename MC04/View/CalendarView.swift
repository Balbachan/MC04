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
    @State var isDone: Bool = false
    @State var date: Date = Date()
    @State private var path = [Habits]()
    @State private var weekCalendar = WeekModel(weeks: [], currentDate: Date(), selectedWeek: 0, selectedDate: Date())
    
    var filteredHabits: [Habits] {
        return habits.filter { $0.verifyDateInterval(date: weekCalendar.selectedDate) }
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            GeometryReader { geometry in
                VStack {
                    // Calendar
                    WeekScroll(weekModel: $weekCalendar)
                        .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.2)
                    
                    // List
                    VStack {
                        List {
                            ForEach(filteredHabits) { habit in
                                NavigationLink(value: habit) {
                                    Text(habit.name)
                                    
                                }
                            }
                            .onDelete(perform: deleteHabit)
                        }
                    }
                }
                .navigationTitle("Home")
                .navigationDestination(for: Habits.self, destination: EditTaskView.init)
                .toolbar {
                    Button("Add habit", systemImage: "plus", action: addHabit)
                }
            }
        }
    }
    
    // Acho que isso aqui deveria estar na ViewModel
    func addHabit() {
        modelContext.insert(  Habits(id: UUID(), name: "Lavar o rosto", isDone: true, desc: "Indicado de manhã e a noite.Passo essencial para limpar a pele, serve para remover a oleosidade e impurezas.Não esqueça de escolher um sabonete adequado para seu tipo de pele.", steps: [["1","Lave suas mãos", "Antes de começar a lavar o rosto lave suas mãos. Assim você não vai contagiar seu rosto com possíveis bacterias."],["2", "Use água morna", "Cuidado com a temperatura da água sempre tente lavar o rosto com uma água que esteja morna. Água muito quente pode causar danos a pele."]], images: "sdv", startDate: Date(), finalDate: Date(), daysOfWeek: [1], time: Date()))
    }
    
    func deleteHabit(_ indexSet: IndexSet) {
        for index in indexSet {
            let habit = habits[index]
            modelContext.delete(habit)
        }
    }
    
    // Fazer checklist (Laura)
    
}


#Preview {
    CalendarView()
}
