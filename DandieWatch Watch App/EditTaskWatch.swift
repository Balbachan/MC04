
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
    
    var body: some View {
        NavigationStack {
            ScrollView {
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
            }
            .onAppear(perform: {
                if let habitModel = habitTemplate {
                    self.habit = habitModel.newHabits()
                }
            })
//            .padding(.top, 25)
            .padding(.horizontal, 20)
//            .ignoresSafeArea()
        }
        .background(.appWhite)
        .navigationTitle("Selecione os dias")
    }
}




#Preview {
    EditTaskWatch(habitTemplate: ViewModel().habits[0])
        .environmentObject(WeekModel(modelContext: try! ModelContainer(for: Habit.self).mainContext))
}

