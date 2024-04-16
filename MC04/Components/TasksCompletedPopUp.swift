//
//  TasksCompletedPopUp.swift
//  Dandie
//
//  Created by Laura C. Balbachan dos Santos on 16/04/24.
//
// UUID é gerado em tempo de máquina


import SwiftUI

struct TasksCompletedPopUp: View {
    var body: some View {
        VStack {
            Image("dandie4")
                .resizable()
                .scaledToFit()
                .frame(width: 115)
            Text("Parabéns")
                .font(.custom(FontType.t1.font, size: FontType.t1.rawValue))
            Text("você concluir todas as tarefas!")
                .font(.custom(FontType.b1.font, size: FontType.b1.rawValue))
        }
        .foregroundStyle(Color.appOrange)
        .padding(.vertical, 25)
        .padding(.horizontal, 25)
        .background(
            Color.appSuperLightGray
        )
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    TasksCompletedPopUp()
}
