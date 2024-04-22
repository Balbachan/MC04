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

struct WeekPickerWatch: View {
    @Binding var selectedDaysOne: [DayOfWeekOne]
    @Binding var selectedDaysTwo: [DayOfWeekTwo]
    @Binding var numberOfWeeks: Int
    @State var allDays: Bool = false
    @Binding var allWeeks: Bool
    @Binding var weeks: [Int]
    @Binding var hours: Int
    @Binding var minutes: Int
    
    func getWeeks(){
        if allWeeks {
            numberOfWeeks = 10000
        } else {
            numberOfWeeks = weeks.count
        }
    }
    
    
    var body: some View {
        ZStack{
            
            Rectangle()
                .frame(width: 180, height: 165)
                .foregroundColor(.appSuperLightGray)
                .cornerRadius(20)
                .padding(.top,30)
            
        
            
            VStack{
                //Título
                Text("Quais dias")
                    .font(.system(size: 18))
                    .fontWeight(.black)
                    .foregroundStyle(Color.black)
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
                
                VStack(spacing: 0){
                    Text("Horário notificação:")
                        .font(.system(size: 13))
                        .foregroundColor(.black)
                        .bold()
                    
                    //Picker de horas
                    HStack {
                        Picker("", selection: $hours){
                            ForEach(0..<24, id: \.self) { i in
                                Text("\(i)").tag(i)
                                    .font(.custom(FontType.t3.font, size: FontType.t3.rawValue))
                            }
                        }.frame(width: 70, height: 40)
                        
                        Text(":")
                            .font(.custom(FontType.t3.font, size: FontType.t3.rawValue))
                        
                        Picker("", selection: $minutes){
                            ForEach(0..<60, id: \.self) { i in
                                Text("\(i)").tag(i)
                                    .font(.custom(FontType.t3.font, size: FontType.t3.rawValue))
                            }
                        }.frame(width: 70, height: 40)
                    }
                }
                
                
                //            Button("Adicionar tarede"){
                //                saveHabit()
                //                .dismiss()
                //            }.buttonStyle(DandiButtonWatch(isOrange: false))
                //                .padding(.top)
            }
        }
        .padding(.top)
        .frame(width: 200)
        .ignoresSafeArea()
    }
}



#Preview {
    WeekPickerWatch(selectedDaysOne: .constant([.Segunda,.Quarta]), selectedDaysTwo: .constant([.Domingo, .Quinta]), numberOfWeeks: .constant(2), allWeeks: .constant(false), weeks: .constant([1]), hours: .constant(10), minutes: .constant(09))
}
