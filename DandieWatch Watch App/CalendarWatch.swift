import Foundation
import Aptabase
import SwiftUI
import SwiftData

struct CalendarWatch: View {
    @EnvironmentObject private var weekModel: WeekModel
    
    var body: some View {
        NavigationStack() {
            GeometryReader { geometry in
                VStack(alignment: .leading, spacing: 0) {
                    
                    // Calendar
                    WeekScrollWatch()
                        .frame(height: geometry.size.height / 5)
                    
                    // Título Hoje
                    HStack {
                        Text("Hoje")
                            .font(.custom("Digitalt", size: 28))
                            .fontWeight(.bold)
                        Spacer()
                        NavigationLink {
                            SuggestionWatch()
                                .onAppear(perform: {
                                    Aptabase.shared.trackEvent("plusSymbol")
                                    print("plus")
                                })
                        } label: {
                            Image(systemName: "plus")
                                .bold()
                                .tint(.appOrange)
                        }
                    }.padding(.top)
                    
                    VStack(alignment: .center, spacing: 10) {
                        if(weekModel.filteredHabits().isEmpty){
                            Image("null")
                                .resizable()
                                .scaledToFit()
                            //                                .frame(width: geometry.size.width * 0.9)
                        } else {
                            
                            List {
                                ForEach(weekModel.filteredHabits(), id: \.self) { habit in
                                    NavigationLink(destination: DescriptionWatch(habits: habit)
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
                                                }
                                        }
                                }.listRowBackground(
                                        Rectangle()
                                            .fill(Color.appSuperLightGray)
                                            .cornerRadius(20)
                                            .padding(2)
                                    )
                                
                            }
                            .listStyle(.plain)
                            .environment(\.defaultMinListRowHeight, 70)
                            
                            
                        }
//                        HabitCountView()
                        
                        Spacer()
                        
                    }
                }
            }
            .padding(20)
            .background(.appWhite)
            
        }
    }
}


#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Habit.self, configurations: config)
        let _ = Habit(id: UUID(), name: "Lavar o rosto", isDone: true, desc: "Indicado de manhã e a noite.Passo essencial para limpar a pele, serve para remover a oleosidade e impurezas.Não esqueça de escolher um sabonete adequado para seu tipo de pele.", steps: [["1","Lave suas mãos", "Antes de começar a lavar o rosto lave suas mãos. Assim você não vai contagiar seu rosto com possíveis bacterias."],["2", "Use água morna", "Cuidado com a temperatura da água sempre tente lavar o rosto com uma água que esteja morna. Água muito quente pode causar danos a pele."]], images: "sdv", startDate: Date(), finalDate: Date(), daysOfWeek: [1], time: Date())
        return CalendarWatch()
            .modelContainer(container)
    } catch {
        fatalError("Alguém me desconfigurou")
    }
}
