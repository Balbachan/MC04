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
                        .frame(height: geometry.size.height / 5)
                    
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
                    }.padding(.top)
                    
                    VStack(){
                        List(){
                            ForEach(weekModel.filteredHabits(), id: \.self) { habit in
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

//#Preview {
//    CalendarView(showOnboarding: false, date: Date(), isDone: false)
//}

