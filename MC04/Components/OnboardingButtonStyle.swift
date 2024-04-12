//
//  DandiButtonStyle.swift
//  MC04
//
//  Created by Laura C. Balbachan dos Santos on 09/04/24.
//

import SwiftUI

struct OnboardingButtonStyle: ButtonStyle {
    var size: CGFloat = 250
    var isOrange: Bool = true
    func makeBody(configuration: Configuration) -> some View {
        if(isOrange) {
            configuration.label
                .font(.custom("Digitalt", size: 24))
                .foregroundStyle(Color.appBeige)
                .padding(.vertical, 20)
                .frame(width: size)
                .background(configuration.isPressed ? Color(.appMediumGray) : Color.appOrange)
                .clipShape(RoundedRectangle(cornerRadius: 20))
        } else {
            configuration.label
                
                .font(.custom("Digitalt", size: 24))
                .foregroundStyle(Color.appBeige)
                .padding(.vertical, 20)
                .frame(width: size)
                .background(configuration.isPressed ? Color(.appMediumGray) : Color.appBlack)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
        }
    }
}

#Preview {
    Button("Pular") {
        print("aaaa")
    }
    .buttonStyle(OnboardingButtonStyle(isOrange: false))
}
