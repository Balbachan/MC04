//
//  WeekModel.swift
//  MC04
//
//  Created by Igor Bragança Toledo on 28/03/24.
//

import Observation
import Foundation
import SwiftData
import UserNotifications
import SwiftUI


class WeekModel: ObservableObject {
    @Published private (set) var weeks: [Date]
    @Published private (set) var currentDate: Date
    @Published private (set) var selectedWeekIndex: Int
    @Published private var modelContext: ModelContext
    @Published var habits: [Habit] = []
    
    var selectedDate: Date {
        didSet {
            calculateSelectedWeekIndex()
        }
    }
    
    init(modelContext: ModelContext) {
        let today = Date()
        
        self.weeks = []
        self.currentDate = today
        self.selectedDate = today
        self.selectedWeekIndex = 0
        self.modelContext = modelContext
        
        Task {
            await MainActor.run {
                fetchData()
                updateWeeks(date: self.currentDate)
                calculateSelectedWeekIndex()
            }
        }
    }
    
    @MainActor
    func fetchData() {
        do {
            let descriptor = FetchDescriptor<Habit>()
            habits = try modelContext.fetch(descriptor)
        } catch {
            print("Fetch failed")
        }
    }
    
    func addHabit(_ habit: Habit) {
        modelContext.insert(habit)
        Task {
            await MainActor.run {
                fetchData()
            }
        }
    }
    
    func deleteHabit(_ habit: Habit) {
        modelContext.delete(habit)
        Task {
            await MainActor.run {
                fetchData()
            }
        }
    }
    
    private func calculateSelectedWeekIndex() {
        let weekOfYearSelectedDate = Calendar.current.component(.weekOfYear, from: selectedDate)
        let weekOfYearCurrentDate = Calendar.current.component(.weekOfYear, from: currentDate)
        self.selectedWeekIndex = (weeks.count / 2) + (weekOfYearSelectedDate - weekOfYearCurrentDate)
    }
    
    @MainActor
    private func updateWeeks(date: Date) {
        let componentDay = DateComponents(weekday: 1)
        let calendar = Calendar.current
        var weeks:[Date] = []
        
        if let firstDayOfThisWeek = calendar.nextDate(after: date, matching: componentDay, matchingPolicy: .previousTimePreservingSmallerComponents, direction: .backward) {
            
            for i in -2...2 {
                if let newDate = calendar.date(byAdding: .weekOfYear, value: i, to: firstDayOfThisWeek) {
                    weeks.append(newDate)
                } else {
                    print("problema em calcular semana")
                    return
                }
            }
            self.weeks = weeks
        } else {
            print("problema em calcular o primeiro dia da semana")
        }
    }
    
    //Filtra os Habitos de hoje na CalendarView
    private func filteredHabits(date: Date) -> [Habit] {
        return habits.filter { $0.verifyDateInterval(date: date) }
    }
    
    //Filtra os Habitos de hoje na CalendarView
    func filteredHabits() -> [Habit] {
        return filteredHabits(date: selectedDate)
    }
    
    //Salva o habito 4
//    func saveHabit4(habit: Habit, selectedDays: [DayOfWeek], numberOfWeeks: Int) {
//        DispatchQueue(label: "com.example.queue").async {
//            let calendar = Calendar.current
//            let startDate = calendar.startOfDay(for: Date())
//            
//            for selectedDay in selectedDays {
//                guard let nextDay = calendar.nextDate(after: startDate, matching: DateComponents(weekday: selectedDay.rawValue), matchingPolicy: .nextTime) else {
//                    continue
//                }
//                
//                for weekIndex in 0..<numberOfWeeks {
//                    let startDateOfWeek = calendar.date(byAdding: .weekOfYear, value: weekIndex, to: nextDay)!
//                    let finalDateOfWeek = calendar.date(byAdding: .day, value: 6, to: startDateOfWeek)!
//                    
//                    let habitForDay = Habit()
//                    
//                    habitForDay.name = habit.name
//                    habitForDay.desc = habit.desc
//                    habitForDay.steps = habit.steps
//                    habitForDay.startDate = startDateOfWeek
//                    habitForDay.finalDate = finalDateOfWeek
//                    habitForDay.daysOfWeek = [selectedDay.rawValue]
//                    
//                    self.addHabit(habitForDay)
//                    print("O Hábito: \(habitForDay.name) está sendo criados nos dias: \(habitForDay.daysOfWeek)")
//                }
//            }
//        }
//    }
    
    //Salva o Habito 1
    func saveHabit(habit: Habit, selectedDays: [DayOfWeek], numberOfWeeks: Int) {
        DispatchQueue(label: "com.example.queue").async {
            
            let calendar = Calendar.current
            let startDate = calendar.startOfDay(for: Date())
            
            for selectedDay in selectedDays {
                
                self.addHabit(Habit(name: habit.name, desc: habit.desc, steps: habit.steps, startDate: startDate, finalDate: calendar.date(byAdding: .day, value: numberOfWeeks * 7, to: startDate)!, daysOfWeek: [selectedDay.rawValue]))
            }
        }
    }
    
    //Manda as notificações
    func notification(_ hora: Int, _ min: Int, _ week: [DayOfWeek], _ repeats : Bool){
        
        let habit: Habit = Habit()
        
        if week.count > 0{
            //faz um for de notificacoes
            for days in week{
                print("dias \(days.rawValue)")
                let content = UNMutableNotificationContent()
                content.title =  "\(habit.name)"
                content.subtitle = "Lembre-se de se cuidar"
                content.sound = UNNotificationSound.default
                
                var datComp = DateComponents()
                datComp.hour = hora
                datComp.minute = min
                datComp.weekday = days.rawValue
                
                // show this notification at 7.30 everyday
                let trigger = UNCalendarNotificationTrigger(dateMatching: datComp, repeats: repeats)
                
                // choose a random identifier
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                
                // add our notification request
                UNUserNotificationCenter.current().add(request)
            }
        } else {
            let content = UNMutableNotificationContent()
            content.title =  "\(habit.name)"
            content.subtitle = "Lembre-se de se cuidar"
            content.sound = UNNotificationSound.default
            
            var datComp = DateComponents()
            datComp.hour = hora
            datComp.minute = min
            datComp.weekday = week.first?.rawValue
            
            
            // show this notification at 7.30 everyday
            let trigger = UNCalendarNotificationTrigger(dateMatching: datComp, repeats: repeats)
            
            
            // choose a random identifier
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            
            // add our notification request
            UNUserNotificationCenter.current().add(request)
        }
    }
    
    //Função que calcula quantos hábitos estão prontos
    var sumDone: Int {
        var sumTotal = 0
        let filteredHabits = filteredHabits()
        
        for habit in filteredHabits where habit.isDone == true {
            sumTotal += 1
        }
        return sumTotal
    }
    
    //Função que devolve a cor dos dias da semana
    func calendarColours(date: Date) -> Color {
        let habtis = filteredHabits(date: date)
        
        // conta quantos estão acabados
        let sumDone = habtis.reduce(0) { partialResult, habit in
            return habit.isDone ? partialResult + 1 : partialResult
        }
        
        if sumDone == 0 && habtis.count == 0 {
            return Color(.appSuperLightGray)
        }
        
        if sumDone == habtis.count {
            return Color(.appOrange)
        } else if sumDone > 0 && sumDone < habtis.count {
            return Color(.appYellow)
        } else {
            return Color(.appSuperLightGray)
        }
    }
}



//Funções que podem ser usadas

//Salvar o Habito 2
//    func saveHabit(habit: Habit, selectedDays: [DayOfWeek], numberOfWeeks: Int) {
//        DispatchQueue(label: "com.example.queue").async {
//
//            let calendar = Calendar.current
//            let startDate = calendar.startOfDay(for: Date())
//
//            for weekIndex in 0..<numberOfWeeks {
//                for selectedDay in selectedDays {
//
//                    var dateComponents = DateComponents()
//                    dateComponents.weekOfYear = weekIndex
//                    dateComponents.weekday = selectedDay.rawValue
//
//                    if let habitStartDate = calendar.nextDate(after: startDate, matching: dateComponents, matchingPolicy: .nextTime) {
//                        let habitEndDate = calendar.date(byAdding: .day, value: 6, to: habitStartDate)!
//
//                        var habitForDay = habit
//                        habitForDay.startDate = habitStartDate
//                        habitForDay.finalDate = habitEndDate
//                        habitForDay.daysOfWeek = [selectedDay.rawValue]
//
//                        self.addHabit(habitForDay)
//                    }
//                }
//            }
//        }
//    }


//Salva o Habito 3
//    func saveHabit(habit: Habit, selectedDays: [DayOfWeek], numberOfWeeks: Int) {
//        DispatchQueue(label: "com.example.queue").async {
//
//            let calendar = Calendar.current
//            let startDate = calendar.startOfDay(for: Date())
//            var habitsDays = [Habit]()
//            for selectedDay in selectedDays {
//
//                let habitForDay = Habit()
//
//                habitForDay.name = habit.name
//                habitForDay.desc = habit.desc
//                habitForDay.steps = habit.steps
//
//                habitForDay.startDate = startDate
////                habitForDay.finalDate = calendar.date(byAdding: .day, value: numberOfWeeks * 7, to: startDate)!
//                habitForDay.daysOfWeek = [selectedDay.rawValue]
//
//                habitsDays.append(habitForDay)
////                self.addHabit(habitForDay)
//            }
//
//            for habitsDay in habitsDays {
//                for i in 0..<numberOfWeeks{
//                    let habitForDay = Habit()
//                    habitForDay.name = habit.name
//                    habitForDay.desc = habit.desc
//                    habitForDay.steps = habit.steps
//
//                    habitForDay.startDate = habitsDay.startDate
//
//                    habitForDay.finalDate = calendar.date(byAdding: .day, value: i, to: startDate)!
//                    habitForDay.daysOfWeek = habitsDay.days
//                    self.addHabit(habitForDay)
//                }
//            }
//        }
//    }

//Salva o Habito 1
//    func saveHabit(habit: Habit, selectedDays: [DayOfWeek], numberOfWeeks: Int) {
//        DispatchQueue(label: "com.example.queue").async {
//
//            let calendar = Calendar.current
//            let startDate = calendar.startOfDay(for: Date())
//
//            for selectedDay in selectedDays {
//
//                let habitForDay = Habit()
//
//                habitForDay.name = habit.name
//                habitForDay.desc = habit.desc
//                habitForDay.steps = habit.steps
//
//                habitForDay.startDate = startDate
//                habitForDay.finalDate = calendar.date(byAdding: .day, value: numberOfWeeks * 7, to: startDate)!
//                habitForDay.daysOfWeek = [selectedDay.rawValue]
//
//                self.addHabit(habitForDay)
//            }
//        }
//    }
