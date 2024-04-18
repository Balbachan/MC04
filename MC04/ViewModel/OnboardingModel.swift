//
//  OnboardingModel.swift
//  Dandie
//
//  Created by Igor Bragança Toledo on 17/04/24.
//

import Foundation

struct OnboardingModel: Observable {
    let introduction: [String] = ["Prazer! Meu nome é Dandie e meu objetivo\naqui é te auxiliar a ter uma rotina de\nautocuidado.", "Nessa tela você poderá: \nAcompanhar sua rotina\nAdicionar novas tarefas\nVer suas tarefas do dia", "Ao escolher alguma dessas tarefas que fiz\npara você, basta definir o(s) dia(s), se ela irá\nse repetir e o horário que irá realizá-la.", "Viu como é fácil?\n Eu estarei aqui acompanhando seu\nprogresso, além de te lembrar de fazer as\ntarefas, seguir sua rotina com excelência\ne te dar dicas."]
    
    let introImagesLight: [String] = ["dandie1", "dandie2", "dandie3", "dandie4"]
}
