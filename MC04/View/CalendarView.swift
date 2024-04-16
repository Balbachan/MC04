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
    @AppStorage("isOnboarding") var showOnboarding: Bool = true
    @EnvironmentObject private var weekModel: WeekModel
    
    @State var date: Date = Date()
    @State var isDone: Bool = false
//    var funcModels: FuncModels

    
    var filteredHabits: [Habit] {
        return weekModel.filteredHabits()
    }
    
    
    var body: some View {
        NavigationStack() {
            GeometryReader { geometry in
                VStack(alignment: .leading, spacing: 0) {
                    
                    // Frase de efeito diária
                    Text("Bora reagir meu chapa")
                        .font(.custom("Digitalt", size: 28))
                        .fontWeight(.bold)
                    
                    // Calendar
                    WeekScroll()
                        .frame(height: geometry.size.height / 4.6)
                        .padding(.top, 25)
                    
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
                    
                    VStack(){
                        List(){
                            ForEach(filteredHabits, id: \.self) { habit in
                                NavigationLink(destination: DescriptionView(habits: habit)){
                                    
                                    Image(habit.isDone ? "checkBoxOn" : "checkBoxOff")
                                        .tint(.appOrange)
                                        .onTapGesture {
                                            habit.isDone.toggle()
                                        }
                                    
                                    Text(habit.name)
                                        .font(.custom("Digitalt", size: 20))
                                        .swipeActions {
                                            NavigationLink {
                                                // EditTaskView(habits: habit)
                                            } label: {
                                                Image(systemName: "pencil")
                                            }
                                        }
                                        .swipeActions {
                                            Button {
                                                weekModel.deleteHabit(habit)
                                            } label: {
                                                Image(systemName: "trash")
                                            }
                                            .tint(.red)
                                            .cornerRadius(20)
                                        }
                                }
                            }.listRowSeparator(.hidden)
                                .listRowBackground(
                                    Rectangle()
                                        .fill(Color.appSuperLightGray)
                                        .cornerRadius(20)
                                        .padding(2)
                                )
                            
                        }
                        .listStyle(.plain)
                        .environment(\.defaultMinListRowHeight, 70)
                    }
                    
                    HabitCountView()
                }
                
            }
            .padding(20)
            .background(.appWhite)
            
        }
        // Chama o Onboarding
        .fullScreenCover(isPresented: $showOnboarding, content: {
            OnboardingView(isPresented: $showOnboarding)
        })
    }
    
}



#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Habit.self, configurations: config)
        let _ = Habit(id: UUID(), name: "Lavar o rosto", isDone: true, desc: "Indicado de manhã e a noite.Passo essencial para limpar a pele, serve para remover a oleosidade e impurezas.Não esqueça de escolher um sabonete adequado para seu tipo de pele.", steps: [["1","Lave suas mãos", "Antes de começar a lavar o rosto lave suas mãos. Assim você não vai contagiar seu rosto com possíveis bacterias."],["2", "Use água morna", "Cuidado com a temperatura da água sempre tente lavar o rosto com uma água que esteja morna. Água muito quente pode causar danos a pele."]], images: "sdv", startDate: Date(), finalDate: Date(), daysOfWeek: [1], time: Date())
        return CalendarView()
            .modelContainer(container)
    } catch {
        fatalError("Alguém me desconfigurou")
    }
}

struct HabitCountView: View {
    @EnvironmentObject private var weekModel: WeekModel
    
    private var filteredHabits: [Habit] {
        return weekModel.filteredHabits()
    }
    
    private var sumDone: Int {
        var sumTotal = 0
        let filteredHabits = weekModel.filteredHabits()
        
        for habit in filteredHabits where habit.isDone == true {
            sumTotal += 1
        }
        return sumTotal
    }
    
    var body: some View {
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
