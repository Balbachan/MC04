//
//  SuggestionsView.swift
//  MC04
//
//  Created by Beatriz Andreucci on 03/04/24.
//

import SwiftUI
import SwiftData

struct SuggestionsView: View {
    var viewModel: ViewModel = ViewModel()
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
   
    
    var body: some View {
        if horizontalSizeClass == .compact {
            VStack {
                // Título da Seção
                
                HStack {
                    Text("Hábitos")
                        .font(.custom("Digitalt", size: 28))
                        .fontWeight(.bold)
                    Spacer()
                }
                
                
                ScrollView {
                    
                    
                    VStack(alignment: .center, spacing: 10) {
                        ForEach(viewModel.habits) { habit in
                            NavigationLink(destination: EditTaskView(habitModel: habit)) {
                                ZStack{
                                    RoundedRectangle(cornerRadius: 25)
                                        .foregroundColor(Color("CinzaCard"))
                                        .frame(height: 100)
                                        .frame(width: 390)
                                    Text("\(habit.name)") // Coloca o nome do hábito no botão
                                        .font(.custom("Digitalt", size: 25))
                                        .foregroundColor(.black)
                                    
                                }
                            }
                        }
                    }
                    
                    //                NavigationLink {
                    //                    Text("aaa")
                    //                } label: {
                    //                    Text("Confirmar rotina")
                    //                        .foregroundColor(Color("AmareloAlert"))
                    //                        .background(RoundedRectangle(cornerRadius: 10)
                    //                            .foregroundColor(Color("Confirm"))
                    //                            .frame(height: 70)
                    //                            .frame(width: 390))
                    //                }.padding(.top, 22)
                }
            }
            .padding(20)
        }else if horizontalSizeClass == .regular  {
            VStack {
                // Título da Seção
                HStack {
                    Text("Hábitos")
                        .font(.custom("Digitalt", size: 60))
                        .fontWeight(.bold)
                    Spacer()
                }
                
                
                ScrollView {
                    
                    
                    VStack(alignment: .center, spacing: 20) {
                        ForEach(viewModel.habits) { habit in
                            NavigationLink(destination: EditTaskView(habitModel: habit)) {
                                ZStack{
                                    RoundedRectangle(cornerRadius: 25)
                                        .foregroundColor(Color("CinzaCard"))
                                        .frame(height: 150)
                                        .frame(width: 600)
                                    Text("\(habit.name)") // Coloca o nome do hábito no botão
                                        .font(.custom("Digitalt", size: 45))
                                        .foregroundColor(.black)
                                    
                                }
                            }
                        }
                    }
                    
                    //                NavigationLink {
                    //                    Text("aaa")
                    //                } label: {
                    //                    Text("Confirmar rotina")
                    //                        .foregroundColor(Color("AmareloAlert"))
                    //                        .background(RoundedRectangle(cornerRadius: 10)
                    //                            .foregroundColor(Color("Confirm"))
                    //                            .frame(height: 70)
                    //                            .frame(width: 390))
                    //                }.padding(.top, 22)
                }
            }
            .padding(20)
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Habits.self, configurations: config)
        return SuggestionsView()
            .modelContainer(container)
    } catch {
        fatalError("Alguém me desconfigurou")
    }
}
