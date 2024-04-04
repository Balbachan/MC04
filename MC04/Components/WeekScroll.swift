//
//  WeekScroll.swift
//  MC04
//
//  Created by Igor Bragança Toledo on 31/03/24.
//

import Foundation
import SwiftUI

import SwiftUI

struct WeekScroll: View {
    @State var viewModel = WeekModel()
    @State var update = false;
    
    var body: some View {
        GeometryReader { geometry in
            ScrollViewReader { value in
                VStack {
                    ScrollView(.horizontal) {
                        LazyHStack(spacing: 0) {
                            ForEach(viewModel.weeks.indices, id: \.self) { index in
                                ZStack {
                                    if update {
                                        WeekHeader(firstDay: viewModel.weeks[index], selectedDate: $viewModel.selectedDate)
                                    } else {
                                        WeekHeader(firstDay: viewModel.weeks[index], selectedDate: $viewModel.selectedDate)
                                    }
                                }
                                .frame(width: geometry.size.width, height: 70)
                                .onAppear(perform: {
                                    value.scrollTo(Int(viewModel.weeks.count / 2))
                                    print(viewModel.weeks.count)
                                })
                            }
                        }
                        .scrollTargetLayout()
                    }
                    .scrollTargetBehavior(.viewAligned)
                    
                    
                }
                //                Spacer()
                //                Text("Data selecionada: \(viewModel.selectedDate)")
                //                Button {
                //                    value.scrollTo(viewModel.selectedWeekIndex)
                //                } label: {
                //                    ZStack {
                //                        RoundedRectangle(cornerSize: CGSize(width: 20, height: 20))
                //                            .foregroundStyle(.blue)
                //                        Text("Mostrar data selecionada")
                //                            .foregroundStyle(.white)
                //
                //                    }
                //                    .frame(height: 56)
                //                }
                //                .padding()
                //
                //                Spacer()
                //            }
                //            .onChange(of: viewModel.selectedDate, initial: false) { oldValue, newValue in
                //                update.toggle()
                //            }
            }
        }
    }
}

#Preview {
    WeekScroll()
}
