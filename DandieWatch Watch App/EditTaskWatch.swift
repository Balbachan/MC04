
//
// EditTaskView.swift
// MC04
//
// Created by Laura C. Balbachan dos Santos on 02/04/24.
//

import SwiftUI
import SwiftData

struct EditTaskWatch: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) var dis
    @State var habits: Habits = Habits()
    @State var selectedDaysOne: [DayOfWeekOne] = []
    @State var selectedDaysTwo: [DayOfWeekTwo] = []
    @State var numberOfWeeks: Int = 1
    
    var habitModel: HabitModel?
    
    private func saveHabit() {
        DispatchQueue(label: "com.example.queue").async {
            
            // adiciona no habito a data de início e fim
            let calendar = Calendar.current
            habits.startDate = calendar.startOfDay(for: Date())
            habits.finalDate = Calendar.current.date(byAdding: .day, value: numberOfWeeks * (7), to: habits.startDate)!
            
            // adiciona no habito os dias da semana
            self.habits.daysOfWeek = selectedDaysOne.map{$0.rawValue}
            self.habits.daysOfWeek = selectedDaysTwo.map{$0.rawValue}
            
            // salva o habito
            modelContext.insert(self.habits)
            //            print("StartDate -> \(self.habits.startDate)")
            //            print("FinalDate -> \(self.habits.finalDate)")
        }
    }
    
    private func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
    
    var body: some View {
        NavigationStack{
            VStack {
//                Text("\(habits.desc)")
                
//                Spacer()
                
                WeekPickerWatch(selectedDaysOne: $selectedDaysOne, selectedDaysTwo: $selectedDaysTwo, numberOfWeeks: $numberOfWeeks)
                
//                Spacer()
                
//                Button("Adicionar tarede"){
//                    saveHabit()
//                    .dismiss()
//                }.buttonStyle(DandiButtonWatch())
//                    .padding(.top)
//                
          
                // Esse botão aparece só se a pessoa estiver vindo
                
                Button("Continuar adicionando") {
                    saveHabit()
                    dismiss()
                    print(habits.name)
                }
                .buttonStyle(DandiButtonWatch())
//                .padding(.bottom)
                
                //            Button("Adicionar tarede"){
                //                saveHabit()
                //                .dismiss()
                //            }.buttonStyle(DandiButtonWatch(isOrange: false))
                //                .padding(.top)
                
                
//                Button("Concluir Rotina") {
//                    saveHabit()
//                }
//                .buttonStyle(DandiButtonStyle(isOrange: false))
                
                
            }.onAppear(perform: {
                if let habitModel = habitModel {
                    self.habits = habitModel.newHabits()
                }
            })
            .padding(.horizontal)
        }
    }
}




#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Habits.self, configurations: config)
        let example =  HabitModel(name: "Lavar o rosto", desc: "Indicado de manhã e a noite.Passo essencial para limpar a pele, serve para remover a oleosidade e impurezas.Não esqueça de escolher um sabonete adequado para seu tipo de pele.", steps: [["1","Lave suas mãos", "Antes de começar a lavar o rosto lave suas mãos. Assim você não vai contagiar seu rosto com possíveis bacterias."],["2", "Use água morna", "Cuidado com a temperatura da água sempre tente lavar o rosto com uma água que esteja morna. Água muito quente pode causar danos a pele."]], images: "sdv")
        return EditTaskWatch(habitModel: example)
            .modelContainer(container)
    } catch {
        fatalError("Alguém me desconfigurou")
    }
}


