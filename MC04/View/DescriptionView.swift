//
//  DescriptionView.swift
//  MC04
//
//  Created by Beatriz Andreucci on 03/04/24.
//

import SwiftUI
import SwiftData

struct DescriptionView: View {
//    @Environment(\.modelContext) var modelContext
//    @Query var habits: [Habits]
    @Bindable var habits: Habits
    
    var body: some View {
        VStack{
            Text("\(habits.desc)")
                .padding()
            Text("COMO FAZER")
                .font(.title2.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
            
                Steps(habits: habits)
                    .padding()
            VStack{
                Text("!AVISO")
                    .font(.title3.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("Ao ler as descrições e dicas desse aplicativo, lembre-se de que as informações são apenas para referência geral.Este aplicativo não deve ser usado ou entendido como substituto da orientação e acompanhamento de um dermatologista. Os usuários devem sempre consultar um médico ou outro profissional de saúde para receber orientações médicas ou informações sobre diagnósticos e tratamentos.")
                    .font(.system(size: 15))
            }.padding()
            .background(
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(Color("AmareloAlert"))
                        .frame(height: 200)
                        .frame(width: 390)
                        
                )
                
        }
        Spacer()
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Habits.self, configurations: config)
        let example = Habits(id: UUID(), name: "Lavar o rosto", isDone: true, desc: "Indicado de manhã e a noite.Passo essencial para limpar a pele, serve para remover a oleosidade e impurezas.Não esqueça de escolher um sabonete adequado para seu tipo de pele.", steps: [["1","Lave suas mãos", "Antes de começar a lavar o rosto lave suas mãos. Assim você não vai contagiar seu rosto com possíveis bacterias."],["2", "Use água morna", "Cuidado com a temperatura da água sempre tente lavar o rosto com uma água que esteja morna. Água muito quente pode causar danos a pele."]], images: "sdv", startDate: Date(), finalDate: Date(), daysOfWeek: [1], time: Date())
        return DescriptionView(habits: example)
            .modelContainer(container)
    } catch {
        fatalError("Alguém me desconfigurou")
    }
}
