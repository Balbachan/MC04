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
            
            for i in -10...10 {
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
    func filteredHabits() -> [Habit] {
        return habits.filter { $0.verifyDateInterval(date: selectedDate) }
    }
    
    //Salva o Habito Criado
    func saveHabit() {
        
        var selectedDays: [DayOfWeek] = []
        var habit: Habit = Habit()
        var numberOfWeeks: Int = 1
        
        DispatchQueue(label: "com.example.queue").async {
            
            // adiciona no habito a data de início e fim
            let calendar = Calendar.current
            
            habit.startDate = calendar.startOfDay(for: Date())
            habit.finalDate = Calendar.current.date(byAdding: .day, value: numberOfWeeks * (7), to: habit.startDate)!
            
            // adiciona no habito os dias da semana
            habit.daysOfWeek = selectedDays.map{$0.rawValue}
            
            // salva o habito
            self.addHabit(habit)
        }
    }
    
    //Manda as notificações
    func notification(_ hora: Int, _ min: Int, _ week: [DayOfWeek], _ repeats : Bool){
        
        var habit: Habit = Habit()
        
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
        }else{
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
    
}
