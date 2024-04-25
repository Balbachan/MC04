//
//  WeekPickerWatch.swift
//  DandieWatch Watch App
//
//  Created by Beatriz Andreucci on 12/04/24.
//


import SwiftUI
import SwiftData

struct WeekPickerWatch: View {
    @Binding var selectedDays: [DayOfWeek]
    @Binding var numberOfWeeks: Int
    @Binding var allWeeks: Bool
    @Binding var weeks: [Int]
    @Binding var hours: Int
    @Binding var minutes: Int
    
    func getWeeks(){
        if allWeeks {
            numberOfWeeks = 50
        } else {
            numberOfWeeks = weeks.count
        }
    }
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    ForEach(DayOfWeek.allCases.prefix(3), id: \.self) { day in
                        Text(day.name())
                            .font(.system(size: 10))
                            .fontWeight(.heavy)
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
                }
                
                HStack {
                    ForEach(DayOfWeek.allCases.suffix(4), id: \.self) { day in
                        Text(day.name())
                            .font(.system(size: 10))
                            .fontWeight(.heavy)
                            .foregroundColor(selectedDays.contains(day) ? .appBeige : .appBlack)
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
                }
            }
            
            //Toggle repetir toda semana
            HStack{
                Toggle("Repetir toda a semana", isOn: $allWeeks)
                    .toggleStyle(SwitchToggleStyle(tint: .appOrange))
                    .font(.system(size: 12))
                    .foregroundStyle(.appBlack)
                
//                Text("Repetir toda a semana")
//                    .font(.system(size: 12))
//                    .foregroundStyle(.appBlack)
            }
            .padding(.top, 2)
            .padding(.horizontal)
            
            
            
            VStack(spacing: 0){
                Text("Horário notificação")
                    .font(.system(size: 12))
                    .foregroundColor(.appBlack)
                
                // Picker de horário para as notificações
                VStack {
                    HStack {
                        Picker("", selection: $hours){
                            ForEach(0..<24, id: \.self) { i in
                                if(i < 10) {
                                    Text("0\(i)").tag(i)
                                        .font(.custom(FontType.t3.font, size: FontType.t3.rawValue))
                                } else {
                                    Text("\(i)").tag(i)
                                        .font(.custom(FontType.t3.font, size: FontType.t3.rawValue))
                                }
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                        
                        Text(":")
                            .font(.system(size: 22))
                            .fontWeight(.heavy)
                            .foregroundStyle(.appBlack)
                            .padding(.top, 10)
                        
                        Picker("", selection: $minutes){
                            ForEach(0..<60, id: \.self) { i in
                                if(i < 10) {
                                    Text("0\(i)").tag(i)
                                        .font(.custom(FontType.t3.font, size: FontType.t3.rawValue))
                                } else {
                                    Text("\(i)").tag(i)
                                        .font(.custom(FontType.t3.font, size: FontType.t3.rawValue))
                                }
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                    }
                }
                .padding(.bottom, 9)
                .padding(.horizontal, 10)
            }
        }
        .background(.appWhite)
    }
}




#Preview {
    WeekPickerWatch(selectedDays: .constant([.Segunda,.Quarta]), numberOfWeeks: .constant(2), allWeeks: .constant(false), weeks: .constant([1]), hours: .constant(10), minutes: .constant(09))
}
