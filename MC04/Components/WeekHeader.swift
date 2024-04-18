//
//  WeekView.swift
//  POC_SelfCare
//
//  Created by Igor Bragança Toledo on 27/03/24.
//

import Foundation
import SwiftUI
import SwiftData

struct WeekHeader: View {
    @EnvironmentObject private var weekModel: WeekModel
    
    @State var weekDays: [String] = [] // Dias da semana
    @State var weekNumb: [String] = [] // Dias do mês
    @State var weekDate:[Date] = [] // Dia na semana
    @State var selectedIndex: Int? // Dia selecionado
    
    var firstDay: Date = Date()
    
    var body: some View {
        GeometryReader{ geometry in
            HStack{
                Grid {
                    GridRow {
                        ForEach(weekDays.indices, id: \.self) { index in
                            
                            ZStack{
                                VStack {
                                    Spacer()
                                    if index == selectedIndex{
                                        Rectangle()
                                            .foregroundColor(.appWhite)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 100)
                                                    .stroke(Color(weekModel.calendarColours(date: weekDate[index])), lineWidth: 10)
                                            )
                                            .cornerRadius(100)
                                            .frame(height: geometry.size.height)
                                        
                                    } else {
                                        Rectangle()
                                            .foregroundColor(weekModel.calendarColours(date: weekDate[index]))
                                            .cornerRadius(100)
                                            .frame(height: geometry.size.height * 0.7)
                                    }
                                }
                                
                                VStack {
                                    Text("\(weekDays[index])")
                                        .font(.custom(FontType.t1.font, size: 18))
                                        .padding([.top], 20)
                                    Spacer()
                                }
                                
                                Text("\(weekNumb[index])")
                                    .font(.custom(FontType.t1.font, size: 20))
                                    .position(x: geometry.size.width * 0.06, y: geometry.size.height / 1.5)
                            }
                            .onTapGesture {
                                weekModel.selectedDate = weekDate[index]
                                selectedIndex = index
                            }
                        }
                    }
                }
                
            }
        }
        .onAppear(perform: {
            weekDays = []
            weekDate = []
            weekNumb = []
            
            for i in 0..<7 {
                if let date = Calendar.current.date(byAdding: .day, value: i, to: firstDay) {
                    if Calendar.current.compare(date, to: weekModel.selectedDate, toGranularity: .day) == .orderedSame {
                        selectedIndex = i
                    }
                    
                    // Popular o array com os dias da semana
                    let formatterNumb = DateFormatter()
                    let formatter = DateFormatter()
                    
                    formatter.dateFormat = "E"
                    formatter.locale = Locale(identifier: "pt-br")
                    
                    let dayNameWithPeriod = formatter.string(from: date)
                    let dayNameWithoutPeriod = dayNameWithPeriod.replacingOccurrences(of: ".", with: "")
                    
                    weekDays.append(dayNameWithoutPeriod)
                    weekDate.append(date)
                }
            }
            
            for i in 0..<7 {
                if let date = Calendar.current.date(byAdding: .day, value: i, to: firstDay) {
                    if Calendar.current.compare(date, to: weekModel.selectedDate, toGranularity: .day) == .orderedSame {
                        selectedIndex = i
                    }
                    
                    // Popular o array com os dias da semana
                    let formatterNumb = DateFormatter()
                    let formatter = DateFormatter()
                    
                    formatter.dateFormat = "dd"
                    formatter.locale = Locale(identifier: "pt-br")
                    
                    let dayNameWithPeriod = formatter.string(from: date)
                    let dayNameWithoutPeriod = dayNameWithPeriod.replacingOccurrences(of: ".", with: "")
                    
                    weekNumb.append(dayNameWithoutPeriod)
                    weekDate.append(date)
                }
            }
        })
    }
    
    //    var body: some View {
    //        GeometryReader { geometry in
    //            HStack(spacing: 5){
    //                ForEach(weekDays.indices, id: \.self) { index in
    //                    VStack(spacing: 0) {
    //                        ZStack{
    //                            Text("\(weekDays[index])")
    //                                .multilineTextAlignment(.center)
    //                                .font(.custom(FontType.t1.font, size: 17))
    //                        }
    //                    }
    //                    .padding(.horizontal, 10)
    //                    .background(
    //                        Capsule()
    //                            .frame(width: geometry.size.width / 10)
    //                            .frame(height: index == selectedIndex ? geometry.size.height * 0.9 : geometry.size.height * 0.5)
    //                            .position(y: index ==  selectedIndex ? geometry.size.height * 0.5 : geometry.size.height * 0.65)
    //                            .foregroundStyle(index == selectedIndex ? .appOrange : .appSuperLightGray)
    //                            .animation(.easeInOut)
    //                            .padding(40)
    //                            .padding(.bottom, 70)
    //                    )
    //                    .onTapGesture {
    //                        weekModel.selectedDate = weekDate[index]
    //                        selectedIndex = index
    //                    }
    //                }
    //            }
    //            .onAppear(perform: {
    //                weekDays = []
    //                weekDate = []
    //
    //                for i in 0..<7 {
    //                    if let date = Calendar.current.date(byAdding: .day, value: i, to: firstDay) {
    //                        if Calendar.current.compare(date, to: weekModel.selectedDate, toGranularity: .day) == .orderedSame {
    //                            selectedIndex = i
    //                        }
    //
    //                        // Popular o array com os dias da semana
    //                        let formatterNumb = DateFormatter()
    //                        let formatter = DateFormatter()
    //                        formatter.dateFormat = "E"
    //                        formatter.locale = Locale(identifier: "pt-br")
    //                        let dayNameWithPeriod = formatter.string(from: date)
    //                        let dayNameWithoutPeriod = dayNameWithPeriod.replacingOccurrences(of: ".", with: "")
    //                        weekDays.append(dayNameWithoutPeriod)
    //                        weekDate.append(date)
    //                    }
    //                }
    //            })
    //        }
    //    }
}

#Preview {
    WeekHeader(firstDay: Date())
        .environmentObject(WeekModel(modelContext: try! ModelContainer(for: Habit.self).mainContext))
}


//
//
//ForEach(weekDays.indices, id: \.self) { index in
//    ZStack{
//        VStack{
//            Spacer()
//            if index == selectedIndex{
//                Rectangle()
//                    .foregroundColor(.appWhite)
//                    .overlay(
//                        RoundedRectangle(cornerRadius: 100)
//                            .stroke(Color.appOrange, lineWidth: 10)
//                    )
//                    .cornerRadius(100)
//                    .frame(height: geometry.size.height)
//                
//            } else {
//                Rectangle()
//                    .foregroundColor(weekModel.calendarColours(date: weekDate[index]))
//                    .cornerRadius(100)
//                    .frame(height: geometry.size.height * 0.7)
//            }
//        }
//        Text("\(weekNumb[index])")
//            .font(.custom(FontType.t1.font, size: 20))
//        
//        Text("\(weekDays[index])")
//            .font(.custom(FontType.t1.font, size: 20))
//            .position(x: geometry.size.width / 17, y: 10)
//    }
//    .onTapGesture {
//        weekModel.selectedDate = weekDate[index]
//        selectedIndex = index
//    }
//}
