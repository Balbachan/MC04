//
//  DandiButtonStyle.swift
//  MC04
//
//  Created by Laura C. Balbachan dos Santos on 09/04/24.
//

import SwiftUI

struct DandiButtonStyle: ButtonStyle {
    var isOrange: Bool = true
    
    func makeBody(configuration: Configuration) -> some View {
        GeometryReader { geometry in
            if(isOrange) {
                configuration.label
                    .frame(width: geometry.size.width * 1)
                    .font(.custom("Digitalt", size: 24))
                    .foregroundStyle(Color.appBeige)
                    .padding(.vertical, 25)
                    .background(configuration.isPressed ? Color(.appMediumGray) : Color.appOrange)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            } else {
                configuration.label
                    .frame(width: geometry.size.width * 1)
                    .font(.custom("Digitalt", size: 24))
                    .foregroundStyle(Color.appBeige)
                    .padding(.vertical, 25)
                    .background(configuration.isPressed ? Color(.appMediumGray) : Color.appBlack)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
        }
    }
}

#Preview {
    Button("Continuar Adicionando") {
        print("aaaa")
    }
    .buttonStyle(DandiButtonStyle(isOrange: false))
}
