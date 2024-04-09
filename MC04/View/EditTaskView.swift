//
// EditTaskView.swift
// MC04
//
// Created by Laura C. Balbachan dos Santos on 02/04/24.
//
import SwiftUI
import SwiftData
struct EditTaskView: View {
    @Environment(\.modelContext) var modelContext
    @State var habits: Habits = Habits()
    
    var habitModel: HabitModel?
    
    var body: some View {
        VStack {
            
            Text("\(habits.desc)")
            
            Spacer()
            
            WeekPicker()
            
            Spacer()
            
            Form {
                Section {
                    DatePicker (
                        "Dia inicial",
                        selection: $habits.startDate,
                        displayedComponents: [.date]
                    )
                    .datePickerStyle(.compact)
                }
                
                Section {
                    DatePicker (
                        "Dia final",
                        selection: $habits.finalDate,
                        displayedComponents: [.date]
                    )
                    .datePickerStyle(.compact)
                }
            }
            .scrollContentBackground(.hidden)
            .navigationTitle("\(habits.name)")
            
            // Esse botão aparece só se a pessoa estiver vindo
            Button("Adicionar tarefa") {
                DispatchQueue(label: "com.example.queue").async {
                    modelContext.insert(self.habits)
                    
                }
                
            }.foregroundColor(Color("AmareloAlert"))
                .background(RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color("Confirm"))
                    .frame(height: 70)
                    .frame(width: 4000))
            
        }.onAppear(perform: {
            if let habitModel = habitModel {
                self.habits = habitModel.newHabits()
            }
        })
        .onChange(of: habits.startDate) { oldValue, newValue in
            if habits.startDate > habits.finalDate {
                habits.finalDate = habits.startDate
            }
        }
        
        .onChange(of: habits.finalDate) { oldValue, newValue in
            if habits.startDate > habits.finalDate {
                habits.startDate = habits.finalDate
            }
        }
        .padding(.horizontal)
    }
}


#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Habits.self, configurations: config)
        let example =  HabitModel(name: "Lavar o rosto", desc: "Indicado de manhã e a noite.Passo essencial para limpar a pele, serve para remover a oleosidade e impurezas.Não esqueça de escolher um sabonete adequado para seu tipo de pele.", steps: [["1","Lave suas mãos", "Antes de começar a lavar o rosto lave suas mãos. Assim você não vai contagiar seu rosto com possíveis bacterias."],["2", "Use água morna", "Cuidado com a temperatura da água sempre tente lavar o rosto com uma água que esteja morna. Água muito quente pode causar danos a pele."]], images: "sdv")
        return EditTaskView(habitModel: example)
            .modelContainer(container)
    } catch {
        fatalError("Alguém me desconfigurou")
    }
}
