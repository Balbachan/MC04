//
// EditTaskView.swift
// MC04
//
// Created by Laura C. Balbachan dos Santos on 02/04/24.
//

import SwiftUI
import SwiftData
import Aptabase

struct EditTaskView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var weekModel: WeekModel
    @State var habit = Habit()
    @State var selectedDays: [DayOfWeek] = []
    @State var numberOfWeeks: Int = 1
    @Binding var dismissToHome: Bool
    @State var allWeeks: Bool = false
    @State var weeks: [Int] = [1,2,3,4,5]
    @State var hours: Int = 0
    @State var minutes: Int = 0
    @State var hasSelectedDays: Bool = false
    
    var habitModel: HabitTemplate?
    
    private func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading){
                Spacer()
                
                Text("\(habit.desc)")
                    .font(.custom(FontType.b1.font, size: 15))
                
                Spacer()
                
                WeekPicker(selectedDays: $selectedDays, numberOfWeeks: $numberOfWeeks, allWeeks: $allWeeks , weeks: $weeks, hours: $hours, minutes: $minutes)
                
                Spacer()
                
                // Esse botão aparece só se a pessoa estiver vindo
                VStack {
                    Button("Continuar adicionando") {
                        weekModel.notification(hours, minutes, selectedDays, allWeeks)
                        weekModel.saveHabit(habit: habit, selectedDays: selectedDays, numberOfWeeks: numberOfWeeks)
                        Aptabase.shared.trackEvent("Continuar Adicionando") // An event with a custom property
                        dismiss()
                    }
                    .disabled(hasSelectedDays)
                    .buttonStyle(DandiButtonStyle())
                    .padding(.bottom)
                    
                    Button("Concluir Rotina") {
                        weekModel.notification(hours, minutes, selectedDays, allWeeks)
                        weekModel.saveHabit(habit: habit, selectedDays: selectedDays, numberOfWeeks: numberOfWeeks)
                        Aptabase.shared.trackEvent("Concluir Rotina") // An event with a custom property
                        dismissToHome.toggle()
                        dismiss()
                    }
                    .buttonStyle(DandiButtonStyle(isOrange: false))
                }.frame(height: 160)
                
                
            }.onAppear(perform: {
                if let habitModel = habitModel {
                    self.habit = habitModel.newHabits()
                }
            })
            .navigationTitle("\(habit.name)")
        }
        .padding(.horizontal)
        .background(.appWhite)
    }
}


#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Habit.self, configurations: config)
        let example =  HabitTemplate(name: "Lavar o rosto", desc: "Essa tarefa é indicada ser realizada no período da manhã e da noite, pois além de limpar a pele, essa etapa remove a oleosidade, as impurezas vindas da poluição e as células mortas. Por isso, a higienização ajuda na desobstrução dos poros, previne o surgimento de cravos e espinhas e ainda dá mais viço ao rosto, deixando-o com uma aparência saudável.", steps: [["1","Lave suas mãos", "Antes de começar a lavar o rosto lave suas mãos. Assim você não vai contagiar seu rosto com possíveis bacterias."],["2", "Use água morna", "Cuidado com a temperatura da água sempre tente lavar o rosto com uma água que esteja morna. Água muito quente pode causar danos a pele."]], images: "sdv")
        return EditTaskView(dismissToHome: .constant(false), habitModel: example)
            .modelContainer(container)
    } catch {
        fatalError("Alguém me desconfigurou")
    }
}
