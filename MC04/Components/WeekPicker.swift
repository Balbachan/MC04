//
//  WeekPicker.swift
//  MC04
//
//  Created by Igor Bragança Toledo on 05/04/24.
//

import SwiftUI
import SwiftData
import UserNotifications

enum DayOfWeek: Int, CaseIterable {
    case Domingo = 1,
         Segunda = 2,
         Terça = 3,
         Quarta = 4,
         Quinta = 5,
         Sexta = 6,
         Sabado = 7
    
    func name() -> String {
        switch self {
        case .Domingo: return "D"
        case .Segunda: return "S"
        case .Terça: return "T"
        case .Quarta: return "Q"
        case .Quinta: return "Q"
        case .Sexta: return "S"
        case .Sabado: return "S"
        }
    }
}

struct WeekPicker: View {
    @Binding var selectedDays: [DayOfWeek]
    @Binding var numberOfWeeks: Int
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
                .foregroundColor(.appSuperLightGray)
                .cornerRadius(20)
                .frame(height: 340)
            
            VStack{
                
                //Título
                Text("Quais dias e repetições")
                    .font(.custom(FontType.t2.font, size: FontType.t2.rawValue))
                
                
                //Seletor de dias da semana
                HStack {
                    ForEach(DayOfWeek.allCases, id: \.self) { day in
                        Text(day.name())
                            .font(.custom(FontType.t4.font, size: FontType.t4.rawValue))
                        //                            .font(.custom("Digitalt", size: 20))
                            .foregroundColor(selectedDays.contains(day) ? Color.appBeige : Color.black)
                            .frame(width: 30, height: 30)
                            .background(selectedDays.contains(day) ? Color.appOrange.cornerRadius(100) : Color.appLightGray.cornerRadius(100))
                            .padding(.horizontal, 5)
                        
                            .onTapGesture {
                                if selectedDays.contains(day) {
                                    selectedDays.removeAll(where: {$0 == day})
                                } else {
                                    selectedDays.append(day)
                                    //                                    print(day)
                                }
                            }
                    }
                }.padding(.vertical)
                
                //Picker de semanas
                //                HStack {
                //                    Text("Durante")
                //                        .font(.custom(FontType.b1.font, size: FontType.b2.rawValue))
                //
                //                    Picker("", selection: $numberOfWeeks) {
                //                        ForEach(weeks, id: \.self) {
                //                            Text("\($0)")
                //                                .font(.custom(FontType.t2.font, size: FontType.t2.rawValue))
                //                        }
                //                    }.pickerStyle(.wheel)
                //
                //                    Text("Semanas")
                //                        .font(.custom(FontType.b1.font, size: FontType.b2.rawValue))
                //
                //                }.frame(width: 250, height: 80)
                
                
                //Toggle repetir toda semana
                HStack{
                    Toggle("Repetir toda semana", isOn: $allWeeks)
                        .font(.custom(FontType.b1.font, size: FontType.b1.rawValue))
                        .toggleStyle(SwitchToggleStyle(tint: .appOrange))
                        .frame(width: 250)
                        .padding(. bottom, 15)
                }.padding(.top, 10)
                    .onChange(of: allWeeks) {
                        getWeeks()
                        print(allWeeks)
                    }
                
                Text("Definir horário para notificação:")
                    .font(.custom(FontType.b1.font, size: 16))
                
                //Picker de horas
                HStack {
                    Picker("", selection: $hours){
                        ForEach(0..<24, id: \.self) { i in
                            Text("\(i)").tag(i)
                                .font(.custom(FontType.t3.font, size: FontType.t3.rawValue))
                        }
                    }.pickerStyle(WheelPickerStyle())
                    
                    Text(":")
                        .font(.custom(FontType.t3.font, size: FontType.t3.rawValue))
                    
                    Picker("", selection: $minutes){
                        ForEach(0..<60, id: \.self) { i in
                            Text("\(i)").tag(i)
                                .font(.custom(FontType.t3.font, size: FontType.t3.rawValue))
                        }
                    }.pickerStyle(WheelPickerStyle())
                }.frame(width: 180, height: 90)
            }
        }
    }
}

//#Preview {
//    WeekPicker(selectedDays: .constant([.Domingo,.Terça]), numberOfWeeks: .constant(3))
//}
