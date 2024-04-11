//
//  SuggestionButtonStyle.swift
//  MC04
//
//  Created by Laura C. Balbachan dos Santos on 04/04/24.
//

import SwiftUI

struct SuggestionButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.custom("Digitalt", size: 25))
            .foregroundStyle(Color.appBlack)
            .frame(width: 350, height: 100) // MARK: aqui está com número fixo
            
            .background(configuration.isPressed ? Color.appDarkGray : Color.appSuperLightGray)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            
            
    }
}

#Preview {
    Button("Esfoliação") {
        print("aaaa")
    }
    .buttonStyle(SuggestionButtonStyle())
}
