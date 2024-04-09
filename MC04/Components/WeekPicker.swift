//
//  WeekPicker.swift
//  MC04
//
//  Created by Igor Bragança Toledo on 05/04/24.
//

import SwiftUI
import SwiftData

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
                    ForEach(DayOfWeek.allCases, id: \.self) { day in
                        Text(day.name())
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
//                                    print(day)
                                }
                            }
                    }
                }.padding(.vertical)
                
                HStack {
                    Text("Durante")
                    Picker("", selection: $numberOfWeeks) {
                        ForEach([1,2,3,4,5], id: \.self) {
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
    WeekPicker(selectedDays: .constant([.Domingo,.Terça]), numberOfWeeks: .constant(3))
}
