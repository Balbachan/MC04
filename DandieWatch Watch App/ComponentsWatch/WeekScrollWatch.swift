//
//  WeekScrollWatch.swift
//  DandieWatch Watch App
//
//  Created by Beatriz Andreucci on 11/04/24.
//

//
//  WeekScroll.swift
//  MC04
//
//  Created by Igor Bragança Toledo on 31/03/24.
//

import Foundation
import SwiftUI
import SwiftData

struct WeekScrollWatch: View {
    
    @EnvironmentObject private var weekModel: WeekModel
//    @Environment private var wh: WeekHeader
    @AppStorage("teste") var teste: Bool = true
    
    var body: some View {
        GeometryReader { geometry in
            ScrollViewReader { value in
                VStack {
                    ScrollView(.horizontal) {
                        LazyHStack(spacing: 0) {
                            ForEach(weekModel.weeks.indices, id: \.self) { index in
                                ZStack {
                                    WeekHeaderWatch(firstDay: weekModel.weeks[index])
                                        .padding(.top)
                                }
                                .frame(width: geometry.size.width, height: geometry.size.height)
                                .onAppear(perform: {
                                    if teste {
                                        value.scrollTo(Int(weekModel.weeks.count / 2))
                                        teste = false
                                    }
                                })
                            }
                        }
                        .scrollTargetLayout()
                    }
                    .ignoresSafeArea()
                    .scrollIndicators(.hidden)
                    .scrollTargetBehavior(.viewAligned)
                }
            }
        }
    }
}


#Preview {
    WeekScrollWatch()
        .environmentObject(WeekModel(modelContext: try! ModelContainer(for: Habit.self).mainContext))
}

