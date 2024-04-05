//
//  SuggestionButtonStyle.swift
//  MC04
//
//  Created by Laura C. Balbachan dos Santos on 04/04/24.
//

import SwiftUI

struct SuggestionButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        GeometryReader { geometry in
            configuration.label
                .font(.title)
                .bold()
                .frame(width: 340)
                .frame(height: 100)
                .background(configuration.isPressed ? Color.cinzaNumber : Color.cinzaCard)
                .clipShape(RoundedRectangle(cornerRadius: 20))    
        }
    }
}


#Preview {
    Button("Lavar o rosto"){
        print("aaaa")
    }
    .buttonStyle(SuggestionButtonStyle())
}
