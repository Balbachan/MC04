//
//  WeekScroll.swift
//  MC04
//
//  Created by Igor Bragança Toledo on 31/03/24.
//

import Foundation
import SwiftUI
import SwiftData

struct WeekScroll: View {
    
    @EnvironmentObject private var weekModel: WeekModel
        
    var body: some View {
        GeometryReader { geometry in
            ScrollViewReader { value in
                VStack {
                    ScrollView(.horizontal) {
                        LazyHStack(spacing: 0) {
                            ForEach(weekModel.weeks.indices, id: \.self) { index in
                                ZStack {
                                        WeekHeader(firstDay: weekModel.weeks[index])
                                            .padding(.bottom)
                                   
                                }
                                .frame(width: geometry.size.width, height: geometry.size.height )
                                .onAppear(perform: {
                                    value.scrollTo(Int(weekModel.weeks.count / 2))
                                })
                            }
                        }
                        .scrollTargetLayout()
                    }
                    .scrollIndicators(.hidden)
                    .scrollTargetBehavior(.viewAligned)
                }
            }
        }
    }
}


#Preview {
    WeekScroll()
        .environmentObject(WeekModel(modelContext: try! ModelContainer(for: Habit.self).mainContext))
}
