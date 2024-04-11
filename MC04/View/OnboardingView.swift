//
//  OnboardingView.swift
//  Dandie
//
//  Created by Laura C. Balbachan dos Santos on 11/04/24.
//

import SwiftUI

struct OnboardingView: View {
    let introduction: [String] = ["Prazer! meu nome é Dandie e meu objetivo aqui é te auxiliar a ter uma rotina de autocuidado.", "Nessa tela você poderá: \nAcompanhar sua rotina\nAdicionar novas tarefas\nVer suas tarefas do dia", "Ao escolher alguma dessas tarefas que fiz para você, basta definir o(s) dia(s), se ela irá se repetir e o horário que irá realizá-la.", "Viu como é fácil? Eu estarei aqui acompanhando seu progresso, além de te lembrar de fazer as tarefas, seguir sua rotina com excelência e te dar dicas."]
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    OnboardingView()
}
