//
//  WeekScroll.swift
//  MC04
//
//  Created by Igor Bragança Toledo on 31/03/24.
//

import Foundation
import SwiftUI

struct WeekScroll: View {
    @Binding var viewModel: WeekModel
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
                                .frame(width: geometry.size.width, height: 110)
                                .onAppear(perform: {
                                    value.scrollTo(Int(viewModel.weeks.count / 2))
                                })
                            }
                        }
                        .scrollTargetLayout()
                    }
                    .scrollTargetBehavior(.viewAligned)
                    
                }
            }
        }
    }
}


#Preview {
    WeekScroll(viewModel: .constant(WeekModel()))
}
