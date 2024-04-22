//
//  CalendarHeader.swift
//  Dandie
//
//  Created by Laura C. Balbachan dos Santos on 22/04/24.
//

import SwiftUI

struct CalendarHeader: View {
//    var vm: ViewModel
    
    var body: some View {
        HStack {
            Image("hidandie")
            Text("Frase do dia")
                .font(.custom(FontType.t1.font, size: FontType.t1.rawValue))
        }
    }
}

#Preview {
    CalendarHeader()
}
