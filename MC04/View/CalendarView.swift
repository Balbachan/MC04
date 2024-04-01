//
//  PocView.swift
//  POC_SelfCare
//
//  Created by Igor Bragança Toledo on 26/03/24.
//

import Foundation
import SwiftUI

struct CalendarView: View {
    
    // Calendar Variables
    @State private var dateCalendar = Date()
    
    struct Habit: Identifiable {
        let id = UUID()
        let name: String
        let dateHabit: Date
    }
    
    private var habits = [
        Habit(name: "Barba", dateHabit: Date()),
        Habit(name: "Lavar rosto", dateHabit: Date()),
        Habit(name: "Cabelo", dateHabit: Calendar.current.date(byAdding: .day, value: 1, to: Date())!),
        Habit(name: "Bigode", dateHabit: Calendar.current.date(byAdding: .day, value: 2, to: Date())!),
        Habit(name: "Pele", dateHabit: Calendar.current.date(byAdding: .day, value: 3, to: Date())!),
        Habit(name: "Unhas", dateHabit: Calendar.current.date(byAdding: .day, value: 4, to: Date())!)
    ]
    
    var filteredHabits: [Habit] {
        let selectedDate = Calendar.current.startOfDay(for: dateCalendar)
        return habits.filter { Calendar.current.startOfDay(for: $0.dateHabit) == selectedDate }
    }
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter
    }()
    
    @State private var multiSelection = Set<UUID>()
    
    var body: some View {
        NavigationView{
            GeometryReader{ geometry in
                VStack{
                    
                    // Calendar
                    DatePicker("Dates Available", selection: $dateCalendar, displayedComponents: [.date])
                        .datePickerStyle(.graphical)
                        .frame(width: geometry.size.width / 1.15)
                    
//                    CustomWeekHeader()
                    
                    
                    // List
                    List(filteredHabits) { habit in
                        HStack {
                            Text(habit.name)
                            Spacer()
                            Text(dateFormatter.string(from: habit.dateHabit))
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    .listStyle(.plain)
                    
//                    // Text showing number of selected habits
//                    if filteredHabits.count == 0{
//                        Text("\(filteredHabits.count) feito")
//                            .foregroundStyle(Color.red)
//                    } else if habits.count == filteredHabits.count {
//                        Text("\(filteredHabits.count) Concluidos 🎉")
//                            .foregroundStyle(Color.green)
//                    } else {
//                        Text("\(filteredHabits.count) feitos")
//                            .foregroundStyle(Color.yellow)
//                    }
                }
                .navigationTitle("POC")
            }
        }
    }
}


#Preview {
    CalendarView()
}
