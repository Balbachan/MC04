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
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0){
                ForEach(week.indices, id: \.self) { index in
                    ZStack {
                        Rectangle()
                            .foregroundStyle(index == selectedIndex ? .appOrange : .appMediumGray)
                            .frame(height: index == selectedIndex ? geometry.size.height * 1 : geometry.size.height * 0.5)
                            .cornerRadius(100)
                            .padding(.horizontal, 9)
                            if horizontalSizeClass == .compact {
                        
                                Text("\(week[index])")
                                    .font(.custom("Digitalt", size: 17))
                                    .multilineTextAlignment(.center)
                                    .position(x: geometry.size.width * 0.07, y: geometry.size.height / 7)
                            }
                            else if horizontalSizeClass == .regular  {
                        
                                Text("\(week[index])")
                                    .font(.custom("Digitalt", size: 30))
                                    .multilineTextAlignment(.center)
                                    .position(x: geometry.size.width * 0.07, y: geometry.size.height / 7)
                            }
                    }
                    .frame(width: geometry.size.width / 7)
                    .onTapGesture {
                        selectedDate = weekDate[index]
                        selectedIndex = index
                    }
                }
            }
            .position(x: geometry.size.width / 2 ,y: geometry.size.height / 2)
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
