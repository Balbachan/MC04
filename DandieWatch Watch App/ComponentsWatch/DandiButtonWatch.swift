//
//  DandiButtonWatch.swift
//  DandieWatch Watch App
//
//  Created by Beatriz Andreucci on 11/04/24.
//


import SwiftUI

struct DandiButtonWatch: ButtonStyle {
    var isOrange: Bool = true
    
    func makeBody(configuration: Configuration) -> some View {
//        GeometryReader { geometry in
            if(isOrange) {
                configuration.label
                    .font(.custom("Digitalt", size: 10))
                    .foregroundStyle(Color.appBeige)
                    .padding(.vertical, 13)
                    .padding(.horizontal, 19)
                    .background(configuration.isPressed ? Color(.appMediumGray) : Color.appOrange)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            } else {
                configuration.label
                    .font(.custom("Digitalt", size: 10))
                    .foregroundStyle(Color.appBeige)
                    .padding(.vertical, 13)
                    .padding(.horizontal, 19)
                    .background(configuration.isPressed ? Color(.appMediumGray) : Color.appBlack)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
        }
    }
//}

#Preview {
    Button("Confirmar Rotina") {
        print("aaaa")
    }
    .buttonStyle(DandiButtonWatch(isOrange: false))
}
