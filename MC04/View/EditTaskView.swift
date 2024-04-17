//
// EditTaskView.swift
// MC04
//
// Created by Laura C. Balbachan dos Santos on 02/04/24.
//

import SwiftUI
import SwiftData

struct EditTaskView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var weekModel: WeekModel
    
    @State var habit: Habit = Habit()
    @State var selectedDays: [DayOfWeek] = []
    @State var numberOfWeeks: Int = 1
    @Binding var dismissToHome: Bool
    @State var allWeeks: Bool = false
    @State var weeks: [Int] = [1,2,3,4,5]
    @State var hours: Int = 0
    @State var minutes: Int = 0
    
    var habitModel: HabitTemplate?
    
//    private func saveHabit() {
//        DispatchQueue(label: "com.example.queue").async {
//            
//            // adiciona no habito a data de início e fim
//            let calendar = Calendar.current
//            
//            habit.startDate = calendar.startOfDay(for: Date())
//            habit.finalDate = Calendar.current.date(byAdding: .day, value: numberOfWeeks * (7), to: habit.startDate)!
//            
//            // adiciona no habito os dias da semana
//            self.habit.daysOfWeek = selectedDays.map{$0.rawValue}
//            
//            // salva o habito
//            weekModel.addHabit(self.habit)
//        }
//    }
    
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
                VStack{
                    Button("Continuar adicionando") {
                        weekModel.notification(hours, minutes, selectedDays, allWeeks)
                        weekModel.saveHabit()
                        dismiss()
                    }
                    .buttonStyle(DandiButtonStyle())
                    .padding(.bottom)
                    
                    Button("Concluir Rotina") {
                        weekModel.notification(hours, minutes, selectedDays, allWeeks)
                        weekModel.saveHabit()
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
        let example =  HabitTemplate(name: "Lavar o rosto", desc: "Indicado de manhã e a noite.Passo essencial para limpar a pele, serve para remover a oleosidade e impurezas.Não esqueça de escolher um sabonete adequado para seu tipo de pele.", steps: [["1","Lave suas mãos", "Antes de começar a lavar o rosto lave suas mãos. Assim você não vai contagiar seu rosto com possíveis bacterias."],["2", "Use água morna", "Cuidado com a temperatura da água sempre tente lavar o rosto com uma água que esteja morna. Água muito quente pode causar danos a pele."]], images: "sdv")
        return EditTaskView(dismissToHome: .constant(false), habitModel: example)
            .modelContainer(container)
    } catch {
        fatalError("Alguém me desconfigurou")
    }
}
