//
//  WeekPicker.swift
//  MC04
//
//  Created by Igor Bragança Toledo on 05/04/24.
//

import SwiftUI
import SwiftData
import UserNotifications

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
                .frame(height: 350)
            
            VStack{
                //Título
                Text("Quais dias e repetições")
                    .font(.custom(FontType.t2.font, size: FontType.t2.rawValue))
                
                //Seletor de dias da semana
                HStack {
                    ForEach(DayOfWeek.allCases, id: \.self) { day in
                        Text(day.name())
                            .font(.custom(FontType.t4.font, size: FontType.t4.rawValue))
                            .foregroundColor(selectedDays.contains(day) ? Color.appBeige : Color.black)
                            .frame(width: 30, height: 30)
                            .background(selectedDays.contains(day) ? Color.appOrange.cornerRadius(100) : Color.appLightGray.cornerRadius(100))
                            .padding(.horizontal, 5)
                        
                            .onTapGesture {
                                if selectedDays.contains(day) {
                                    selectedDays.removeAll(where: {$0 == day})
                                } else {
                                    selectedDays.append(day)
                                    print(day)
                                }
                            }
                    }
                }.padding(.vertical)
                
                //Toggle repetir toda semana
                HStack{
                    Toggle("Repetir toda semana", isOn: $allWeeks)
                        .font(.custom(FontType.b1.font, size: 18))
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

#Preview {
    WeekPicker(selectedDays: .constant([.Domingo, .Terça]), numberOfWeeks: .constant(2), allWeeks: .constant(false), weeks: .constant([1]), hours: .constant(10), minutes: .constant(09))
}
