//
//  WeekPicker.swift
//  MC04
//
//  Created by Igor Bragança Toledo on 05/04/24.
//

import SwiftUI
import SwiftData

struct WeekPicker: View {
    
    @State private var selectedDays: [Day] = []
    @State private var week = "1"
    
    enum Day: String, CaseIterable {
        case Domingo,
             Segunda,
             Terça,
             Quarta,
             Quinta,
             Sexta,
             Sábado
    }
    
    let weeks: [Int] = []
    
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(.gray)
                .cornerRadius(20)
                .frame(height: 250)
            
            VStack{
                Text("Quais dias e repetições")
                    .font(.custom("Digitalt", size: 32))
                
                HStack {
                    ForEach(Day.allCases, id: \.self) { day in
                        
                        Text(String(day.rawValue.first!))
                            .font(.custom("Digitalt", size: 20))
                            .foregroundColor(selectedDays.contains(day) ? Color.yellow : Color.black)
                        
                            .frame(width: 30, height: 30)
                            .background(selectedDays.contains(day) ? Color.orange.cornerRadius(100) : Color.gray.cornerRadius(100))
                            .padding(.horizontal, 5)
                        
                            .onTapGesture {
                                if selectedDays.contains(day) {
                                    selectedDays.removeAll(where: {$0 == day})
                                } else {
                                    selectedDays.append(day)
                                }
                            }
                    }
                }.padding(.vertical)
                
                HStack {
                    Text("Durante")
                    Picker("", selection: $week) {
                        ForEach(["1","2","3"], id: \.self) {
                            Text("\($0)")
                                .font(.custom("Digitalt", size: 30))
                            
                        }
                    }.pickerStyle(.wheel)
                    Text("Semana")
                }.frame(width: 320, height: 80)
            }
        }
    }
}

#Preview {
    WeekPicker()
}
