//
//  DandiButtonStyle.swift
//  MC04
//
//  Created by Laura C. Balbachan dos Santos on 09/04/24.
//

import SwiftUI

struct DandiButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.custom("Digitalt", size: 24))
            .foregroundStyle(Color.appBeige)
            .padding(.vertical, 25)
            .padding(.horizontal, 90)
            .background(configuration.isPressed ? Color(.appDarkGray) : Color.appOrange)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            
    }
}

#Preview {
    Button("Confirmar Rotina") {
        print("aaaa")
    }
    .buttonStyle(DandiButtonStyle())
}
