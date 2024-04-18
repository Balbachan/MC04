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
            .font(.custom("Digitalt", size: 25))
            .foregroundStyle(Color.appBlack)
//            .padding(.vertical, 35)
//            .padding(.horizontal, 90)
            .frame(width: 180, height: 50) // MARK: aqui está com número fixo
            
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
