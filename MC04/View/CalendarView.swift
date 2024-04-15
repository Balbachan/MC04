//
//  PocView.swift
//  POC_SelfCare
//
//  Created by Igor Bragança Toledo on 26/03/24.
//

import Foundation
import SwiftUI
import SwiftData

struct CalendarView: View {
    @State var showOnboarding: Bool = false // para o onboarding
    @State private var isPresented = false
    @Environment(\.modelContext) var modelContext
    @Query var habits: [Habits]
    @State var isDone: Bool = false
    @State var date: Date = Date()
    @State private var path = [Habits]()
    @State private var weekCalendar = WeekModel()
    @State var sumDone = 0
    
    func verifyDone() {
        var sumTotal = 0
        for habit in filteredHabits where habit.isDone == true {
            sumTotal += 1
        }
        sumDone = sumTotal
    }
    
    var filteredHabits: [Habits] {
        return habits.filter { $0.verifyDateInterval(date: weekCalendar.selectedDate) }
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            GeometryReader { geometry in
                VStack(alignment: .leading, spacing: 0) {
                    
                    // Frase de efeito diária
                    Text("Bora reagir meu chapa")
                        .font(.custom("Digitalt", size: 28))
                        .fontWeight(.bold)
                    
                    // Calendar
                    WeekScroll(viewModel: $weekCalendar)
                        .frame(height: geometry.size.height / 5)
                        .padding(.top, 30)
                    
                    // Título Hoje
                    HStack {
                        Text("Hoje")
                            .font(.custom("Digitalt", size: 28))
                            .fontWeight(.bold)
                        Spacer()
                        NavigationLink {
                            SuggestionsView()
                        } label: {
                            Image(systemName: "plus")
                                .bold()
                                .tint(.appOrange)
                        }
                    }
                    .padding(.bottom, 10)
                    
                    VStack(alignment: .center) {
                        List {
                            ForEach(filteredHabits) { habit in
                                NavigationLink(destination: DescriptionView(habits: habit)) {
                                    HStack {
                                        Image(habit.isDone ? "checkBoxOn" : "checkBoxOff")
                                            .tint(.appOrange)
                                            .onTapGesture {
                                                habit.isDone.toggle()
                                                verifyDone()
                                            }
                                        
                                        Text(habit.name)
                                            .font(.custom("Digitalt", size: 20))
                                            .swipeActions {
                                                NavigationLink {
//                                                    EditTaskView(habits: habit)
                                                } label: {
                                                    Image(systemName: "pencil")
                                                }
                                            }
                                        
                                            .swipeActions {
                                                Button {
                                                    modelContext.delete(habit)
                                                } label: {
                                                    Image(systemName: "trash")
                                                }
                                                .tint(.red)
                                            }
                                        
                                    }
                                    
                                    
                                }
                            }
                            .listRowSeparator(.hidden)
                        }
                        .onAppear {
                            verifyDone()
                        }
                        .listStyle(.plain)
                        
                        // Texto de feitos:
                        if sumDone == filteredHabits.count {
                            if filteredHabits.count == 0 {
                                Text("\(sumDone) Feitos")
                                    .font(.custom("Digitalt", size: 24))
                                    .foregroundColor(.appOrange)
                            } else {
                                Text("\(sumDone) Feitos")
                                    .font(.custom("Digitalt", size: 24))
                                    .foregroundColor(.green)
                            }
                        } else if sumDone == 0 {
                            Text("\(sumDone) Feitos")
                                .font(.custom("Digitalt", size: 24))
                                .foregroundColor(.appOrange)
                        } else {
                            Text("\(sumDone) Feitos")
                                .font(.custom("Digitalt", size: 24))
                                .foregroundColor(.appYellow)
                        }
                    }
                    
                }
                .padding(20)
                .background(.appWhite)
                
            }
        }
    }
}


#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Habits.self, configurations: config)
        let _ = Habits(id: UUID(), name: "Lavar o rosto", isDone: true, desc: "Indicado de manhã e a noite.Passo essencial para limpar a pele, serve para remover a oleosidade e impurezas.Não esqueça de escolher um sabonete adequado para seu tipo de pele.", steps: [["1","Lave suas mãos", "Antes de começar a lavar o rosto lave suas mãos. Assim você não vai contagiar seu rosto com possíveis bacterias."],["2", "Use água morna", "Cuidado com a temperatura da água sempre tente lavar o rosto com uma água que esteja morna. Água muito quente pode causar danos a pele."]], images: "sdv", startDate: Date(), finalDate: Date(), daysOfWeek: [1], time: Date())
        return CalendarView()
            .modelContainer(container)
    } catch {
        fatalError("Alguém me desconfigurou")
    }
}
