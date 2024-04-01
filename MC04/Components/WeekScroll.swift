////
////  WeekScroll.swift
////  MC04
////
////  Created by Igor Bragança Toledo on 31/03/24.
////
//
//import Foundation
//import SwiftUI
//
//struct WeekScroll: View {
//    
//    @State var weekModel = WeekModel()
//    @State var update = false;
//    
//    var body: some View {
//        GeometryReader { geometry in
//            ScrollViewReader { value in
//                VStack{
//                    ScrollView(.horizontal){
//                        LazyHStack(spacing: 0){
//                            ForEach(weekModel.weeks.indices, id: \.self) { index in
//                                ZStack {
//                                    if update {
//                                        WeekHeader(firstDay: weekModel.weeks[index], selectedDate: $weekModel.selectedDate)
//                                    } else {
//                                        WeekHeader(firstDay: weekModel.weeks[index], selectedDate: $weekModel.selectedDate)
//                                    }
//                                }
//                            }
//                        }
//                        .scrollTargetLayout()
//                    }
//                    .scrollTargetBehavior(.viewAligned)
//                    .onAppear(perform: {
//                        value.scrollTo(weekModel.weeks.count / 2)
//                    })
//                }
//            }
//        }
//    }
//}
//
//#Preview {
//    WeekScroll()
//}
