//
//  CheckboxToggleStyle.swift
//  MC04
//
//  Created by Laura C. Balbachan dos Santos on 02/04/24.
//

import SwiftUI

struct CheckboxToggleStyle: ToggleStyle {
    @Binding var isDone: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
        Text(configuration.isOn ? "True" : "False")
            .onTapGesture { configuration.isOn.toggle() }
    }
}
