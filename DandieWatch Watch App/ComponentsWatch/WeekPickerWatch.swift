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
    //    @Binding var selectedDaysOne: [DayOfWeekOne]
    //    @Binding var selectedDaysTwo: [DayOfWeekTwo]
    @Binding var numberOfWeeks: Int
    @Binding var allWeeks: Bool
    @Binding var weeks: [Int]
    @Binding var hours: Int
    @Binding var minutes: Int
//    @Binding var allWeeksWatch: Bool
    
//    @State var allDays: Bool = false
    
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
                .frame(width: 180, height: 180)
                .foregroundColor(.appSuperLightGray)
                .cornerRadius(20)
            
            VStack{
                VStack {
                    HStack {
                        ForEach(DayOfWeek.allCases.prefix(3), id: \.self) { day in
                            Text(day.name())
                                .font(.custom(FontType.t1.font, size: FontType.t4.rawValue))
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
                                .font(.custom(FontType.t1.font, size: FontType.t4.rawValue))
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
                }
                
                //Toggle repetir toda semana
                VStack{
                    Toggle("Repetir toda semana", isOn: $allWeeks)
                        .toggleStyle(SwitchToggleStyle(tint: .appOrange))
                        .font(.system(size: 12))
                        .foregroundColor(.black)
                        .frame(width: 160)
                }.padding(.top, 8)
                
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
                    }.frame(height: 20)
                }
            }
        }
    }
}




#Preview {
    WeekPickerWatch(selectedDays: .constant([.Segunda,.Quarta]), numberOfWeeks: .constant(2), allWeeks: .constant(false), weeks: .constant([1]), hours: .constant(10), minutes: .constant(09))
}
