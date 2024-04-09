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
    @State var week: [String] = []
    @State var weekDate:[Date] = []
    @State var selectedIndex: Int?
    @Binding var selectedDate: Date
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 5){
                ForEach(week.indices, id: \.self) { index in
                    VStack(spacing: 0) {
                        Text("\(week[index])")
                            .font(.custom("Digitalt", size: 17))
   
                    }
                    .padding(.horizontal, 10)
                    .background(
                        Capsule()
                            
                            .frame(width: geometry.size.width / 10)
                            .frame(height: index == selectedIndex ? geometry.size.height * 0.9 : geometry.size.height * 0.5)
                            .position(y: index ==  selectedIndex ? geometry.size.height * 0.5 : geometry.size.height * 0.65)
                            .foregroundStyle(index == selectedIndex ? .appSuperLightGray : .appLightGray)
                            .animation(.easeInOut)
                            .padding(40)
                            .padding(.bottom, 70)
                    )
                    .onTapGesture {
                        selectedDate = weekDate[index]
                        selectedIndex = index
                    }
                }
            }
            .onAppear(perform: {
                week = []
                weekDate = []
                
                for i in 0..<7 {
                    if let date = Calendar.current.date(byAdding: .day, value: i, to: firstDay) {
                        if Calendar.current.compare(date, to: selectedDate, toGranularity: .day) == .orderedSame {
                            selectedIndex = i
                        }
                        
                        let formatter = DateFormatter()
                        formatter.dateFormat = "E"
                        formatter.locale = Locale(identifier: "pt-br")
                        let dayNameWithPeriod = formatter.string(from: date)
                        let dayNameWithoutPeriod = dayNameWithPeriod.replacingOccurrences(of: ".", with: "")
                        week.append(dayNameWithoutPeriod)
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
