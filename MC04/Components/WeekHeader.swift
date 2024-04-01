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
            HStack(spacing: 0){
                ForEach(week.indices, id: \.self) { index in
                    ZStack {
                        Rectangle()
                            .foregroundStyle(index == selectedIndex ? .blue : .white)
                            .cornerRadius(10)
                        Text("\(week[index])")
                            .font(.footnote)
                            .multilineTextAlignment(.center)
                    }
                    .frame(width: geometry.size.width / 7)
                    .onTapGesture {
                        selectedDate = weekDate[index]
                        selectedIndex = index
                    }
                }
            }
            .position(x: geometry.size.width / 2 ,y: geometry.size.height / 2)
            .frame(height: geometry.size.height / 8)
            .onAppear(perform: {
                week = []
                weekDate = []
                
                for i in 0..<7 {
                    if let date = Calendar.current.date(byAdding: .day, value: i, to: firstDay) {
                        if Calendar.current.compare(date, to: selectedDate, toGranularity: .day) == .orderedSame {
                            selectedIndex = i
                        }
                        
                        let formatter = DateFormatter()
                        formatter.dateStyle = .medium
                        week.append(formatter.string(from: date))
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
