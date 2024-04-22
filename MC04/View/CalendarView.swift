//
//  PocView.swift
//  POC_SelfCare
//
//  Created by Igor Bragança Toledo on 26/03/24.
//

import Foundation
import SwiftUI
import SwiftData
import Aptabase

struct CalendarView: View {
    @AppStorage("isOnboarding") var showOnboarding: Bool = true
    @EnvironmentObject private var weekModel: WeekModel
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                VStack(alignment: .leading, spacing: 0) {
                    
                    // Frase de efeito diária
                    Text("Bora reagir meu chapa")
                        .font(.custom("Digitalt", size: 28))
                        .fontWeight(.bold)
                        .padding(20)
                    
                    // Calendar
                    WeekScroll()
                        .frame(width: geometry.size.width, height: geometry.size.height / 5)
                    
                    // Título Hoje
                    HStack {
                        Text("Tarefas")
                            .font(.custom(FontType.t1.font, size: 28))
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        NavigationLink {
                            SuggestionsView()
                                .onAppear(perform: {
                                    Aptabase.shared.trackEvent("plusSymbol")
                                    print("plus")
                                })
                        } label: {
                            Image(systemName: "plus")
                                .bold()
                                .tint(.appOrange)
                        }
                    }
                    .padding(20)
                    .padding(.top)
                    
                    VStack(alignment: .center, spacing: 10) {
                        if(weekModel.filteredHabits().isEmpty){
                            Image("null")
                                .resizable()
                                .scaledToFit()
                        } else {
                            List {
                                ForEach(weekModel.filteredHabits(), id: \.self) { habit in
                                    NavigationLink(destination: DescriptionView(habits: habit)
                                        .onAppear(perform: {
                                            Aptabase.shared.trackEvent("descriptions", with: ["name": habit.name])
                                        })){
                                            
                                            // Onde o check é checkado
                                            Image(habit.isDone ? "checkBoxOn" : "checkBoxOff")
                                                .tint(.appOrange)
                                                .onTapGesture {
                                                    habit.isDone.toggle()
                                                    Aptabase.shared.trackEvent("Check", with: ["name": habit.isDone])
                                                }
                                            
                                            Text(habit.name)
                                                .font(.custom("Digitalt", size: 20))
                                            // MARK: Aqui precisa customizar os  botões e arrumar o de edição
                                                .swipeActions {
                                                    Button {
                                                        weekModel.deleteHabit(habit)
                                                    } label: {
                                                        Image(systemName: "trash")
                                                    }
                                                    .tint(.red)
                                                }
                                        }
                                    
                                }
                                .listRowSeparator(.hidden)
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
                        
                        Spacer()
                        
                    }
                    .padding(.horizontal, 20)
                }
            }
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

