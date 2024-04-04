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
                VStack(alignment: .leading, spacing: 0) {
                    
                    // Frase de efeito diária
                    Text("Bora reagir meu chapa")
                        .font(.custom("Digitalt", size: 28))
                        .fontWeight(.bold)
                    
                    
                    // Calendar
                    WeekScroll(weekModel: $weekCalendar)
                        .frame(width: geometry.size.width * 0.9, height: geometry.size.height / 6)
                    
                    
                    // Título Hoje
                    HStack {
                        Text("Hoje")
                            .font(.custom("Digitalt", size: 28))
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        Button("", systemImage: "plus", action: addHabit)

                    }

                    
                    // List
                    List {
                        ForEach(filteredHabits) { habit in
                            NavigationLink(value: habit) {
                                ListRowStyle(habit: habit)
                                    .swipeActions {
                                        Button("", systemImage: "plus", action: addHabit)
                                    
                                        Button("", systemImage: "plus", action: addHabit)
                                    }
                            }
                        }
                        .listRowSeparator(.hidden)
//                        .onDelete(perform: deleteHabit)

                    }
                    .listStyle(.plain)
                    
                    
                    // Frase diária
                    
                    
                    
                }
                .padding(20)
                .navigationDestination(for: Habits.self, destination: EditTaskView.init)
            }
        }
    }
    
    
    
    // Acho que isso aqui deveria estar na ViewModel
    func addHabit() {
        modelContext.insert(Habits(id: UUID(), name: "eee", isDone: true, desc: "sdv", steps: "sdv", images: "sdv", startDate: weekCalendar.selectedDate, finalDate: Date(), daysOfWeek: [4], time: Date()))
    }
    
    func deleteHabit(_ indexSet: IndexSet) {
        for index in indexSet {
            let habit = habits[index]
            modelContext.delete(habit)
        }
    }
}


#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Habits.self, configurations: config)
        let example = Habits(id: UUID(), name: "hoje", isDone: true, desc: "sdv", steps: "sdv", images: "sdv", startDate: Date(), finalDate: Date(), daysOfWeek: [1], time: Date())
        return CalendarView()
            .modelContainer(container)
    } catch {
        fatalError("Alguém me desconfigurou")
    }
}
