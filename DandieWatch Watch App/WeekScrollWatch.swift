////
////  WeekScrollWatch.swift
////  DandieWatch Watch App
////
////  Created by Beatriz Andreucci on 11/04/24.
////
//
////
////  WeekScroll.swift
////  MC04
////
////  Created by Igor Bragança Toledo on 31/03/24.
////
//
//import Foundation
//import SwiftUI
//import SwiftData
//
//struct WeekScrollWatch: View {
//    @EnvironmentObject private var viewModel: WeekModel
//    @State var update = false;
//        
//    var body: some View {
//        GeometryReader { geometry in
//            ScrollViewReader { value in
//                VStack {
//                    ScrollView(.horizontal) {
//                        LazyHStack(spacing: 9) {
//                            ForEach(viewModel.weeks.indices, id: \.self) { index in
//                                ZStack {
//                                    if update {
//                                        WeekHeaderWatch(firstDay: viewModel.weeks[index], selectedDate: $viewModel.selectedDate)
//                                    } else {
//                                        WeekHeaderWatch(firstDay: viewModel.weeks[index], selectedDate: $viewModel.selectedDate)
//                                    }
//                                }
//                                .frame(width: geometry.size.width, height: 110)
//                                .onAppear(perform: {
//                                    value.scrollTo(Int(viewModel.weeks.count / 2))
//                                })
//                            }
//                        }
//                        .scrollTargetLayout()
//                    }
////                    .scrollTargetBehavior(.viewAligned)
//                    
//                }
//            }
//        }
//    }
//}
//
//
//#Preview {
//    WeekScrollWatch()
//        .environmentObject(WeekModel(modelContext: try! ModelContainer(for: Habit.self).mainContext))
//}
