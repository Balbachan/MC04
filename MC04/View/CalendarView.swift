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
    @Environment(\.modelContext) var modelContext
    @Query var habits: [Habits]
    @State var isDone: Bool = false
    @State var date: Date = Date()
    @State var phrases: [String]
    @State private var path = [Habits]()
    @State private var weekCalendar = WeekModel()
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    
    var filteredHabits: [Habits] {
        return habits.filter { $0.verifyDateInterval(date: weekCalendar.selectedDate) }
    }
    
    var body: some View {
        if horizontalSizeClass == .compact { //iphone
        
        NavigationStack(path: $path) {
            GeometryReader { geometry in
                VStack(alignment: .leading, spacing: 0) {
                    
                    // Frase de efeito diária
                    Text("Bora reagir meu chapa")
                        .font(.custom("Digitalt", size: 28))
                        .fontWeight(.bold)
                    
                    // Calendar
                    WeekScroll(viewModel: $weekCalendar)
                        .frame(width: geometry.size.width * 0.9, height: geometry.size.height / 6)
                    
                    // Título Hoje
                    HStack {
                        Text("Rotina")
                            .font(.custom("Digitalt", size: 28))
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        NavigationLink {
                            SuggestionsView()
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                    
                    
                    // List
                    List {
                        ForEach(filteredHabits) { habit in
                            NavigationLink(destination: DescriptionView(habits: habit)) {
                                HStack {
                                    Image(habit.isDone ? "checkBoxOn" : "checkBoxOff")
                                        .onTapGesture {
                                            habit.isDone.toggle()
                                        }
                                        .padding(.trailing, 20)
                                    
                                    Text(habit.name)
                                        .font(.custom("Digitalt", size: 20))
                                        .swipeActions {
                                            NavigationLink {
                                                EditTaskView(habits: habit)
                                            } label: {
                                                Image(systemName: "pencil")
                                            }
                                            
                                        }
                                }
                                
                            }
                        }
                        .listRowSeparator(.hidden)
                        
                        
                    }
                    .listStyle(.plain)
                    
                    .frame(width: geometry.size.width * 0.9, height: geometry.size.height / 2)
                    
                    
                    // Frase diária
                    
                    
                    
                    
                }
                .padding(20)
                //                .navigationDestination(for: HabitModel.self, destination: EditTaskView.init)
            }
        }
        } else if horizontalSizeClass == .regular  { //ipad
            
            NavigationStack(path: $path) {
                GeometryReader { geometry in
                    VStack(alignment: .leading, spacing: 0) {
                        
                        // Frase de efeito diária
                        Text("Bora reagir meu chapa")
                            .font(.custom("Digitalt", size: 40))
                            .fontWeight(.bold)
                            .padding()
                        
                        // Calendar
                        WeekScroll(viewModel: $weekCalendar)
                            .frame(width: geometry.size.width * 0.9, height: geometry.size.height / 6)
                            .padding()
                        // Título Hoje
                        HStack {
                            Text("Rotina")
                                .font(.custom("Digitalt", size: 50))
                                .fontWeight(.bold)
                            
                            Spacer()
                            
                            NavigationLink {
                                SuggestionsView()
                            } label: {
                                Image(systemName: "plus")
                                    .font(.system(size: 40))
                            }
                        }
                        .padding()
                        .padding(.bottom)
                        
                        // List
                        List {
                            ForEach(filteredHabits) { habit in
                                NavigationLink(destination: DescriptionView(habits: habit)) {
                                    HStack {
                                        Image(habit.isDone ? "checkBoxOn" : "checkBoxOff")
                                            .resizable()
                                            .frame(width: 40, height: 40)
                                            .onTapGesture {
                                                habit.isDone.toggle()
                                            }
                                            .padding(.trailing, 20)
                                        
                                        Text(habit.name)
                                            .font(.custom("Digitalt", size: 40))
                                            .swipeActions {
                                                NavigationLink {
                                                    EditTaskView(habits: habit)
                                                } label: {
                                                    Image(systemName: "pencil")
                                                }
                                                
                                            }
                                    }
                                    
                                }
                            }
                            .listRowSeparator(.hidden)
                            
                            
                        }
                        .listStyle(.plain)
                        
                        .frame(width: geometry.size.width * 0.9, height: geometry.size.height / 2)
                        
                        
                        // Frase diária
                        
                        
                        
                        
                    }
                    .padding(20)
                    //                .navigationDestination(for: HabitModel.self, destination: EditTaskView.init)
                }
            }
            }
    }
    
    func addHabit() {
        let habit = Habits()
        modelContext.insert(habit)
        path = [habit]
    }
    
    func deleteHabit(_ indexSet: IndexSet) {
        for index in indexSet {
            let habit = habits[index]
            modelContext.delete(habit)
        }
    }
}


#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Habits.self, configurations: config)
        let _ = Habits(id: UUID(), name: "Lavar o rosto", isDone: true, desc: "Indicado de manhã e a noite.Passo essencial para limpar a pele, serve para remover a oleosidade e impurezas.Não esqueça de escolher um sabonete adequado para seu tipo de pele.", steps: [["1","Lave suas mãos", "Antes de começar a lavar o rosto lave suas mãos. Assim você não vai contagiar seu rosto com possíveis bacterias."],["2", "Use água morna", "Cuidado com a temperatura da água sempre tente lavar o rosto com uma água que esteja morna. Água muito quente pode causar danos a pele."]], images: "sdv", startDate: Date(), finalDate: Date(), daysOfWeek: [1], time: Date())
        return CalendarView(phrases: ["uau"])
            .modelContainer(container)
    } catch {
        fatalError("Alguém me desconfigurou")
    }
}
