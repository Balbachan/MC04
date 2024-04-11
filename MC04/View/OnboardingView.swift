//
//  OnboardingView.swift
//  Dandie
//
//  Created by Laura C. Balbachan dos Santos on 11/04/24.
//

import SwiftUI

struct OnboardingView: View {
    @State private var introIndex: Int = 0
    let introduction: [String] = ["Prazer! meu nome é Dandie e meu objetivo\naqui é te auxiliar a ter uma rotina de\nautocuidado.", "Nessa tela você poderá: \nAcompanhar sua rotina\nAdicionar novas tarefas\nVer suas tarefas do dia", "Ao escolher alguma dessas tarefas que fiz\npara você, basta definir o(s) dia(s), se ela irá se repetir e o horário que irá realizá-la.", "Viu como é fácil?\n Eu estarei aqui acompanhando seu\nprogresso, além de te lembrar de fazer as\ntarefas, seguir sua rotina com excelência\ne te dar dicas."]
    let introImages: [String] = ["dandie1", "dandie1", "dandie1", "dandie1"]
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                // Instruções do Onboarding
                TabView(selection: $introIndex) {
                    ForEach(0..<introduction.count, id: \.self) { index in
                        VStack {
                            Image("\(introImages[index])")
                                .resizable()
                                .scaledToFit()
                                .frame(width: geometry.size.width * 0.4)
                                .padding(30)
                            
                            Text("\(introduction[index])")
                                .multilineTextAlignment(.center)
                        }
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .ignoresSafeArea()
                
                
                // Index em cículos personalizado
                VStack {
                    HStack {
                        ForEach(0..<introduction.count, id: \.self) { index in
                            Circle()
                                .fill(introIndex == index ? Color.appBeige : Color.appLightGray)
                                .frame(width: 22)
                                .onTapGesture {
                                    introIndex = index
                                }
                        }
                        .padding(.bottom, 10)
                    }
                    
                    
                    // Condição para os botões certos aparecerem nas etapas do Onboarding
                    if(introIndex == (introduction.count - 1)) {
                        Button("Vamos começar") {
                            // MARK: Aqui daria um dissmiss para ir para o calendar view
                        }
                        .buttonStyle(DandiButtonStyle(isOrange: false))
                        
                        // Esse não pode existir
                        Button("Pular") {
                            
                        }
                        .buttonStyle(DandiButtonStyle(isOrange: false))
                        
                    } else {
                        Button("Prosseguir") {
                            introIndex += 1
                        }
                        .buttonStyle(DandiButtonStyle(isOrange: true))
                        
                        Button("Pular") {
                            introIndex = (introduction.count - 1)
                        }
                        .buttonStyle(DandiButtonStyle(isOrange: false))
                    }
                }
            }
            .background(.appWhite)
        }
    }
}

#Preview {
    OnboardingView()
}
