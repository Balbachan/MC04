import Foundation
import SwiftData
import SwiftUI



struct WeekHeaderWatch: View {
    @EnvironmentObject private var weekModel: WeekModel
    
    @State var weekDays: [String] = [] // Dias da semana
    @State var weekNumb: [String] = [] // Dias do mês
    @State var weekDate:[Date] = [] // Dia na semana
    @State var selectedIndex: Int? // Dia selecionado
    
    var firstDay: Date = Date()
    
    var body: some View {
        GeometryReader { geometry in
            HStack {
                Grid {
                    GridRow {
                        ForEach(weekDays.indices, id: \.self) { index in
                            ZStack {
                                Text("\(weekDays[index])")
//                                    .font(.custom(FontType.t2.font, size: 18))
                                    .font(.system(size: 9))
                                    .position(x: geometry.size.width * 0.06, y: geometry.size.height * 0.2)
                                        
                                VStack {
                                    Spacer()
                                    if index == selectedIndex{
                                        Capsule()
                                            .stroke(Color(weekModel.calendarColours(date: weekDate[index])), lineWidth: 3)
                                            .foregroundStyle(.appWhite)
                                        
                                    } else {
                                        Capsule()
                                            .foregroundStyle(Color(weekModel.calendarColours(date: weekDate[index])))
                                            .frame(height: geometry.size.height * 0.7)
                                    }
                                }
                    
                                
                                Text("\(weekNumb[index])")
                                    .font(.custom(FontType.b2.font, size: FontType.b2.rawValue))
                                    .position(x: geometry.size.width * 0.06, y: geometry.size.height / 1.5)
                               
                            }.foregroundColor(.black)
                            .onTapGesture {
                                weekModel.selectedDate = weekDate[index]
                                selectedIndex = index
                            }
                        }
                    }
                }
            }
        }
        .padding()
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
}

// Preview
#Preview {
    WeekHeaderWatch(firstDay: Date())
        .environmentObject(WeekModel(modelContext: try! ModelContainer(for: Habit.self).mainContext))
}
