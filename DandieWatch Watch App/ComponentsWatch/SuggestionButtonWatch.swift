//
//  SuggestionButtonWatch.swift
//  DandieWatch Watch App
//
//  Created by Igor Bragança Toledo on 12/04/24.
//

import Foundation
import SwiftUI

struct SuggestionButtonWatch: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 12))
            .foregroundStyle(Color.appBlack)
            .frame(width: 150, height: 30)
            .background(configuration.isPressed ? Color(.appDarkGray) : Color.appSuperLightGray)
            .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    Button("Esfoliação") {
        print("aaaa")
    }
    .buttonStyle(SuggestionButtonWatch())
}
