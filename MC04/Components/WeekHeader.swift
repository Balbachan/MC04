//
//  WeekView.swift
//  POC_SelfCare
//
//  Created by Igor Bragança Toledo on 27/03/24.
//

import Foundation
import SwiftUI

struct WeekHeader: View {
    var firstDay: Date = Date()
    @State var weekDays: [String] = [] // Dias da semana
    @State var weekDate:[Date] = [] // Dia na semana
    @State var selectedIndex: Int? // Dia selecionado
    @Binding var selectedDate: Date // Dia atual
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 5){
                ForEach(weekDays.indices, id: \.self) { index in
                    VStack(spacing: 0) {
                        ZStack {
                            Text("\(weekDays[index])")
                                .font(.custom(FontType.t1.font, size: 17))
                            // Se o selectedIndex apontar para um dia menor que o index 0 da semana atual,
                            
                        }
                    }
                    .padding(.horizontal, 10)
                    .background(
                        Capsule()
                            .frame(width: geometry.size.width / 10)
                            .frame(height: index == selectedIndex ? geometry.size.height * 0.9 : geometry.size.height * 0.5)
                            .position(y: index ==  selectedIndex ? geometry.size.height * 0.5 : geometry.size.height * 0.65)
                            .foregroundStyle(index == selectedIndex ? .appOrange : .appSuperLightGray)
                            .animation(.easeInOut)
                            .padding(40)
                            .padding(.bottom, 70)
                    )
                    .onTapGesture {
                        selectedDate = weekDate[index]
                        selectedIndex = index
                        if(selectedDate < weekDate[index]) {
                            
                        }
                        print("\(String(describing: selectedIndex))")
                        print("\(weekDate[index])")
                        
                    }
                }
            }
            .onAppear(perform: {
                weekDays = []
                weekDate = []
                
                for i in 0..<7 {
                    if let date = Calendar.current.date(byAdding: .day, value: i, to: firstDay) {
                        if Calendar.current.compare(date, to: selectedDate, toGranularity: .day) == .orderedSame {
                            selectedIndex = i
                        }
                        
                        
                        // Popular o array com os dias da semana
                        let formatter = DateFormatter()
                        formatter.dateFormat = "E"
                        formatter.locale = Locale(identifier: "pt-br")
                        let dayNameWithPeriod = formatter.string(from: date)
                        let dayNameWithoutPeriod = dayNameWithPeriod.replacingOccurrences(of: ".", with: "")
                        weekDays.append(dayNameWithoutPeriod)
                        weekDate.append(date)
                    }
                }
            })
        }
    }
}

#Preview {
    WeekHeader(firstDay: Date(), selectedDate: .constant(Date()))
}
