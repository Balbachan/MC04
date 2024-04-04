//
//  ViewModel.swift
//  MC04
//
//  Created by Laura C. Balbachan dos Santos on 27/03/24.
//

// Aqui é onde a comunicação entre as Views e o Model é feito, além de ser onde os dados são alterados

import Foundation
import SwiftData



struct ViewModel: Observable {
    
    var habits: [HabitModel] = [
        HabitModel(name: "Lavar o rosto", desc: "Indicado de manhã e a noite.Passo essencial para limpar a pele, serve para remover a oleosidade e impurezas.Não esqueça de escolher um sabonete adequado para seu tipo de pele.", steps: [["1","Lave suas mãos", "Antes de começar a lavar o rosto lave suas mãos. Assim você não vai contagiar seu rosto com possíveis bacterias."],["2", "Use água morna", "Cuidado com a temperatura da água sempre tente lavar o rosto com uma água que esteja morna. Água muito quente pode causar danos a pele."]], images: "sdv"),
        HabitModel(name: "Hidratação", desc: "Indicado de manhã e a noite.Passo essencial para limpar a pele, serve para remover a oleosidade e impurezas.Não esqueça de escolher um sabonete adequado para seu tipo de pele.", steps: [["a","teste", "Antes de começar a lavar o rosto lave suas mãos. Assim você não vai contagiar seu rosto com possíveis bacterias."],["2", "Use água morna", "Cuidado com a temperatura da água sempre tente lavar o rosto com uma água que esteja morna. Água muito quente pode causar danos a pele."]], images: "sdv"),
        HabitModel(name: "Protetor solar", desc: "Extremamente importante, ajuda a combater o câncer de pele, evitar envelhecimento precoce, flacidez, lesões, entre outras complicações. \n Deve ser usado todos os dias até mesmo no inverno.\nUse um protetor que seja compatível com o que a sua pele", steps: [["1","Pele seca", "É necessário que a pele esteja seca."],["2", "Quantidade necessária", "Coloque o protetor nos seus 3 dedos do meio da mão"], ["3", "Aplique no rosto", ""]], images: "sdv"),
        HabitModel(name: "Esfoliação", desc: "Uma limpeza profunda feita com gel ou creme com minúsculas partículas que desobstrui os poros, elimina as células mortas superficiais e evita pelos encravados \n Deve ser feita uma ou duas vezes por semana", steps: [["1","Aplique o esfoliante no rosto", "Depois de lavar o rosto com a pele ainda úmida, aplique o esfoliante no rosto com as mãos."],["2", "Movimentos circulares", "Faça movimentos circulares suaves por toda a face, dando atenção para testa, nariz e área abaixo da boca, além da região da barba."], ["3", "Enxague"]], images: "sdv")
        
    ]
    
    
    var phrases: [String] = ["Se não quiser virar uma uva passa, comece a usar protetor solar!", "Se não quiser virar uma protetor solar, comece a usar uva passa!"]
}


