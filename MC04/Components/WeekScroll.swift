//
//  WeekScroll.swift
//  MC04
//
//  Created by Igor Bragança Toledo on 31/03/24.
//

import Foundation
import SwiftUI

struct WeekScroll: View {
    
    @Binding var weekModel: WeekModel
    @State var update = false;
    
    var body: some View {
        GeometryReader { geometry in
            ScrollViewReader { value in
                VStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 0) {
                            ForEach(0...weekModel.weeks.indices.count, id: \.self) { index in
                                ZStack {
                                    if update {
                                        WeekHeader(firstDay: weekModel.weeks[index], selectedDate: $weekModel.selectedDate)
                                    } else {
                                        WeekHeader(firstDay: weekModel.weeks[index], selectedDate: $weekModel.selectedDate)
                                    }
                                }
                                .frame(width: geometry.size.width, height: 70)
                            }
                        }
                        .scrollTargetLayout()
                    }
                    .scrollTargetBehavior(.viewAligned)
                    .onAppear(perform: {
                        value.scrollTo(weekModel.weeks.count / 2)
                    })
                }
            }
        }
    }
}

#Preview {
    WeekScroll(weekModel: .constant(WeekModel(weeks: [], currentDate: Date(), selectedWeek: 0, selectedDate: Date())))
}
