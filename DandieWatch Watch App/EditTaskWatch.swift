
//
// EditTaskView.swift
// MC04
//
// Created by Laura C. Balbachan dos Santos on 02/04/24.
//

import SwiftUI
import SwiftData
import Aptabase

struct EditTaskWatch: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var weekModel: WeekModel
    
    @State var habit: Habit = Habit()
    @State var selectedDays: [DayOfWeek] = []
    //    @State var selectedDaysOne: [DayOfWeekOne] = []
    //    @State var selectedDaysTwo: [DayOfWeekTwo] = []
    @State var numberOfWeeks: Int = 1
    @State var allWeeks: Bool = false
    @State var weeks: [Int] = [1,2,3,4,5]
    @State var hours: Int = 0
    @State var minutes: Int = 0
    @State var hasSelectedDays: Bool = false
    
    private func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
    
    var habitTemplate: HabitTemplate?
    
    //    private func saveHabit() {
    //        DispatchQueue(label: "com.example.queue").async {
    //
    //            // adiciona no habito a data de início e fim
    //            let calendar = Calendar.current
    //            habit.startDate = calendar.startOfDay(for: Date())
    //            habit.finalDate = Calendar.current.date(byAdding: .day, value: numberOfWeeks * (7), to: habit.startDate)!
    //
    //            // adiciona no habito os dias da semana
    //            self.habit.daysOfWeek = selectedDaysOne.map{$0.rawValue}
    //            self.habit.daysOfWeek = selectedDaysTwo.map{$0.rawValue}
    //
    //            // salva o habito
    //            weekModel.addHabit(self.habit)
    //        }
    //    }
    
    //    private func saveHabit(habit: Habit, selectedDaysOne: [DayOfWeekOne], numberOfWeeks: Int) {
    //        DispatchQueue(label: "com.example.queue").async {
    //
    //            let calendar = Calendar.current
    //            let startDate = calendar.startOfDay(for: Date())
    //
    //            for selectedDayOne in selectedDaysOne {
    //                let habitForDayOne = Habit()
    //
    //                habitForDayOne.name = habit.name
    //                habitForDayOne.desc = habit.desc
    //                habitForDayOne.steps = habit.steps
    //
    //                habitForDayOne.startDate = startDate
    //                habitForDayOne.finalDate = calendar.date(byAdding: .day, value: numberOfWeeks * 7, to: startDate)!
    //                habitForDayOne.daysOfWeek = [selectedDayOne.rawValue]
    //
    //                self.weekModel.addHabit(habitForDayOne)
    //            }
    //        }
//}
    
//    private func dismiss() {
//        presentationMode.wrappedValue.dismiss()
//    }
    
    var body: some View {
        NavigationStack{
            ScrollView{
//                WeekPickerWatch(selectedDays: $selectedDays, selectedDaysOne: $selectedDaysOne, selectedDaysTwo: $selectedDaysTwo, numberOfWeeks: $numberOfWeeks, allWeeks: $allWeeks , weeks: $weeks, hours: $hours, minutes: $minutes)
                WeekPickerWatch(selectedDays: $selectedDays, numberOfWeeks: $numberOfWeeks, allWeeks: $allWeeks, weeks: $weeks, hours: $hours, minutes: $minutes)
                    .padding(.top,25)
                
                // Esse botão aparece só se a pessoa estiver vindo
                
                Button("Continuar adicionando") {
                    weekModel.notification(hours, minutes, selectedDays, allWeeks)
                    weekModel.saveHabit(habit: habit, selectedDays: selectedDays, numberOfWeeks: numberOfWeeks)
                    Aptabase.shared.trackEvent("Continuar Adicionando Watch")
                    dismiss()
                }
                .buttonStyle(DandiButtonWatch())
            }.onAppear(perform: {
                if let habitModel = habitTemplate {
                    self.habit = habitModel.newHabits()
                }
            })
            .padding(.top, 32)
            .padding(.horizontal)
            .ignoresSafeArea()
        }.background(.appWhite)
            .navigationTitle("Selecione os dias")
    }
}




#Preview {
    EditTaskWatch(habitTemplate: ViewModel().habits[0])
        .environmentObject(WeekModel(modelContext: try! ModelContainer(for: Habit.self).mainContext))
}

