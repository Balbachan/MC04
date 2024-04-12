//
//  WeekPickerWatch.swift
//  DandieWatch Watch App
//
//  Created by Beatriz Andreucci on 12/04/24.
//


import SwiftUI
import SwiftData

enum DayOfWeekOne: Int, CaseIterable {
    case Segunda = 1,
         Terça = 2,
         Quarta = 3
    
    func name() -> String {
        switch self {
        case .Segunda: return "S"
        case .Terça: return "T"
        case .Quarta: return "Q"
        }
    }
}

enum DayOfWeekTwo: Int, CaseIterable {
    case Quinta = 1,
         Sexta = 2,
         Sabado = 3,
         Domingo = 4
    
    func name() -> String {
        switch self {
        case .Quinta: return "Q"
        case .Sexta: return "S"
        case .Sabado: return "S"
        case .Domingo: return "D"
        }
    }
}

struct WeekPicker: View {
    @Binding var selectedDaysOne: [DayOfWeekOne]
    @Binding var selectedDaysTwo: [DayOfWeekTwo]
    @Binding var numberOfWeeks: Int
    @State var allDays: Bool = false
    
    var body: some View {
        VStack{
            //Título
            Text("Quais dias")
                .font(.system(size: 22))
                .fontWeight(.black)
                .foregroundStyle(Color.black)
            
            ZStack{
                Rectangle()
                    .frame(width: 180, height: 140)
                    .foregroundColor(.appSuperLightGray)
                    .cornerRadius(20)
                
                VStack{
                    //Seletor de dias da semana 1
                    HStack {
                        ForEach(DayOfWeekOne.allCases, id: \.self) { day in
                            Text(day.name())
                                .fontWeight(.black)
                                .foregroundColor(selectedDaysOne.contains(day) ? Color.appYellow : Color.black)
                            
                                .frame(width: 30, height: 30)
                                .background(selectedDaysOne.contains(day) ? Color.appOrange.cornerRadius(100) : Color.appLightGray.cornerRadius(100))
                                .padding(.horizontal, 5)
                            
                                .onTapGesture {
                                    if selectedDaysOne.contains(day) {
                                        selectedDaysOne.removeAll(where: {$0 == day})
                                    } else {
                                        selectedDaysOne.append(day)
                                    }
                                }
                        }
                    }
                    
                    
                    //Seletor de dias da semana 2
                    HStack {
                        ForEach(DayOfWeekTwo.allCases, id: \.self) { day in
                            Text(day.name())
                                .fontWeight(.black)
                                .foregroundColor(selectedDaysTwo.contains(day) ? Color.appYellow : Color.black)
                            
                                .frame(width: 30, height: 30)
                                .background(selectedDaysTwo.contains(day) ? Color.appOrange.cornerRadius(100) : Color.appLightGray.cornerRadius(100))
                                .padding(.horizontal, 5)
                            
                                .onTapGesture {
                                    if selectedDaysTwo.contains(day) {
                                        selectedDaysTwo.removeAll(where: {$0 == day})
                                    } else {
                                        selectedDaysTwo.append(day)
                                    }
                                }
                        }
                    }
                    
                    //Toggle repetir toda semana
                    VStack{
                        Toggle("Repetir toda semana", isOn: $allDays)
                            .toggleStyle(SwitchToggleStyle(tint: .appOrange))
                            .font(.system(size: 12))
                            .foregroundColor(.black)
                            .frame(width: 160)
                    }.padding(.top)
                }
            }
            
            Button("Adicionar tarede"){
            }.buttonStyle(DandiButtonWatch(isOrange: false))
                .padding(.top)
            
        }
        .padding(.top)
        .frame(width: 200)
        .background(.appWhite)
        .ignoresSafeArea()
    }
}



#Preview {
    WeekPicker(selectedDaysOne: .constant([.Segunda,.Quarta]), selectedDaysTwo: .constant([.Domingo, .Quinta]), numberOfWeeks: .constant(3))
}
