//
//  DescriptionView.swift
//  MC04
//
//  Created by Beatriz Andreucci on 03/04/24.
//

import SwiftUI
import SwiftData

struct DescriptionView: View {
    @Bindable var habits: Habits
    

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(alignment: .leading) {
                    Text("\(habits.name)")
                        .font(.custom(FontType.t1.font, size: FontType.t1.rawValue))
                    
                    Text("\(habits.desc)")
                        .font(.custom(FontType.b1.font, size: FontType.b2.rawValue))
                    
                    Text("Como fazer")
                        .font(.custom(FontType.t2.font, size: FontType.t2.rawValue))
                        .padding(.top, 20)
                    
                    // Descrição dos hábitos
                    ForEach(habits.steps, id: \.self) { step in
                        HStack(spacing: 15) {
                            VStack {
                                Text(step[0])
                                    .foregroundColor(Color.appYellow)
                                    .font(.custom(FontType.t3.font, size: FontType.t3.rawValue))
                            }
                            .background(
                                Circle()
                                    .fill(Color.appLightGray)
                                    .frame(width: geometry.size.width * 0.075)
                            )
                            .padding(.leading, 10)
                            
                            Text(step[1])
                                .font(.custom(FontType.t3.font, size: FontType.t3.rawValue))
                        }
                        
                        Text(step[2])
                            .font(.custom(FontType.b2.font, size: FontType.b2.rawValue))
                            .padding(.leading, 35)
                            .padding(.bottom, 10)
                    }
                    Spacer(minLength: 25)
                    VStack(alignment: .leading, spacing: 10) {
                        Text("!AVISO")
                            .font(.custom(FontType.t1.font, size: 20))
                        
                        Text("Ao ler as descrições e dicas desse aplicativo, lembre-se de que as informações são apenas para referência geral.Este aplicativo não deve ser usado ou entendido como substituto da orientação e acompanhamento de um dermatologista. Os usuários devem sempre consultar um médico ou outro profissional de saúde para receber orientações médicas ou informações sobre diagnósticos e tratamentos.")
                            .font(.custom(FontType.b2.font, size: FontType.b2.rawValue))
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(Color.appBeige)
                    )
                }
                .padding()
            }
            .background(.appWhite)
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Habits.self, configurations: config)
        let example = Habits(id: UUID(), name: "Lavar o rosto", isDone: true, desc: "Indicado de manhã e a noite.Passo essencial para limpar a pele, serve para remover a oleosidade e impurezas.Não esqueça de escolher um sabonete adequado para seu tipo de pele.", steps: [["1","Lave suas mãos", "Antes de começar a lavar o rosto lave suas mãos. Assim você não vai contagiar seu rosto com possíveis bacterias."],["2", "Use água morna", "Cuidado com a temperatura da água sempre tente lavar o rosto com uma água que esteja morna. Água muito quente pode causar danos a pele."], ["3", "se o sabonete correto e na medida certa", "Tente ir em um dermatologista para ele analisar seu tipo de pele e o sabonete indicado para ela. Apenas um pump do sabonete é o suficiente para lavar o rosto"], ["4", "Lave massageando o rosto ", "Não esfregue o rosto! Espalhe o sabonete em movimentos circulares fazendo uma massagem no rosto"], ["5", "Enxágue o rosto com atenção ", "Enxágue bem o rosto, deixar resíduos de sabonete pode causar irritações."]], images: "sdv", startDate: Date(), finalDate: Date(), daysOfWeek: [1], time: Date())
        return DescriptionView(habits: example)
            .modelContainer(container)
    } catch {
        fatalError("Alguém me desconfigurou")
    }
}
