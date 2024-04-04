//
//  EditTaskView.swift
//  MC04
//
//  Created by Laura C. Balbachan dos Santos on 02/04/24.
//

import SwiftUI
import SwiftData

struct EditTaskView: View {
    @Bindable var habit: Habits
    
    var body: some View {
        VStack {
            Spacer()
            Text("\(habit.desc)")
            
            Form {
                Section {
                    DatePicker (
                        "Dia",
                        selection: $habit.startDate,
                        displayedComponents: [.date]
                    )
                    .datePickerStyle(.compact)
                }
                
                // Esse botão aparece só se a pessoa estiver vindo
                Button {
                    print("aaa")
                } label: {
                    Text("Adicionar tarefa")
                }

            }
            .scrollContentBackground(.hidden)
            .navigationTitle("\(habit.name)")
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Habits.self, configurations: config)
        let example = Habits(id: UUID(), name: "hoje", isDone: true, desc: "sdv", steps: "sdv", images: "sdv", startDate: Date(), finalDate: Date(), daysOfWeek: [1], time: Date())
        return EditTaskView(habit: example)
            .modelContainer(container)
    } catch {
        fatalError("Alguém me desconfigurou")
    }
}
