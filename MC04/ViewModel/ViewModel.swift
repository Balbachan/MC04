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
        HabitModel(name: "Lavar o rosto", desc: "Indicado de manhã e a noite. \nPasso essencial para limpar a pele, serve para remover a oleosidade e impurezas. \nNão esqueça de escolher um sabonete adequado para seu tipo de pele.", steps: [["1","Lave suas mãos", "Antes de começar a lavar o rosto lave suas mãos. Assim você não vai contagiar seu rosto com possíveis bacterias."],["2", "Use água morna", "Cuidado com a temperatura da água sempre tente lavar o rosto com uma água que esteja morna. Água muito quente pode causar danos a pele."], ["3", "se o sabonete correto e na medida certa", "Tente ir em um dermatologista para ele analisar seu tipo de pele e o sabonete indicado para ela. Apenas um pump do sabonete é o suficiente para lavar o rosto"], ["4", "Lave massageando o rosto ", "Não esfregue o rosto! Espalhe o sabonete em movimentos circulares fazendo uma massagem no rosto"], ["5", "Enxágue o rosto com atenção ", "Enxágue bem o rosto, deixar resíduos de sabonete pode causar irritações."]], images: "sdv"),
        HabitModel(name: "Hidratação",  desc: "Hidratar a pele é essencial, ela fortalece a proteção da pele, prevendo o ressecamento, sinais de envelhecimento e diminui o risco de inflamações. \n Tome cuidado e escolha um hidratante ideal para a sua pele com a ajuda de um dermatologista.", steps: [["1","Hidratante no rosto", "Após lavar o rosto passe o hidratante de rosto, no rosto fazendo movimentos circulares"],["2", "Hidratante no corpo", "Após o banho passe o hidratante de corpo, no corpo dando atenção, principalmente, às regiões mais ressecadas"]], images: "sdv"),
        HabitModel(name: "Protetor solar",desc: "Extremamente importante, ajuda a combater o câncer de pele, evitar envelhecimento precoce, flacidez, lesões, entre outras complicações. \n Deve ser usado todos os dias até mesmo no inverno.\nUse um protetor que seja compatível com o que a sua pele", steps: [["1","Pele seca", "É necessário que a pele esteja seca."],["2", "Quantidade necessária", "Coloque o protetor nos seus 3 dedos do meio da mão"], ["3", "Aplique no rosto", ""]], images: "sdv"),
        HabitModel(name: "Esfoliação", desc: "Uma limpeza profunda feita com gel ou creme com minúsculas partículas que desobstrui os poros, elimina as células mortas superficiais e evita pelos encravados \n Deve ser feita uma ou duas vezes por semana", steps: [["1","Aplique o esfoliante no rosto", "Depois de lavar o rosto com a pele ainda úmida, aplique o esfoliante no rosto com as mãos."],["2", "Movimentos circulares", "Faça movimentos circulares suaves por toda a face, dando atenção para testa, nariz e área abaixo da boca, além da região da barba."], ["3", "Enxague", ""]], images: "sdv"),
        HabitModel(name: "Unhas", desc: "Fazer as unhas causa uma boa aparência e uma impressão de cuidado e higiene.", steps: [["1","Molhe as unhas", "Coloque um pouco de água morna em um recipiente e um pouco de sabão e coloque suas unhas "],["2", "Limpe as unhas", "Agora que suas unhas estão úmidas, aproveite para limpá-las com uma escovinha"], ["3", "Corte", "Com uma tesoura própria para isso, corte as unhas de forma arredondada "], ["4", "Lixe as unhas", "Para dar um acabamento às pontas das unhas"], ["5", "Passe hidratante nas unhas", " "]], images: "sdv"),
        HabitModel(name: "Barba", desc: "Tirar a barba", steps: [["1","Lave o rosto com água quente", "Ajuda a abrir os poros, permitindo que a lâmina passe mais facilmente pela pele deixando a pele menos irritada "],["2", "Aplique um gel ou espuma de barbear ", "Faça espuma e espalhe para ajudar a hidratar os pelos, melhorar o deslizamento da lâmina e ajudar a proteger contra irritação."], ["3", " Verifique se a lâmina está cega", "Se as fitas estiverem gastas ou  as lâminas cegas, talvez seja hora de trocar por um novo refil"], ["4", "Faça a barba no sentido do pelo e contra o pelo", "O pelo facial cresce em muitas direções, por isso você vai ter de raspar tanto no sentido de crescimento quanto contra"], ["5", "Lave o rosto com água fria", " "], ["6", "Use loção pós barba hidratante", " "]], images: "sdv")
    ]
    
    
    var phrases: [String] = ["Se não quiser virar uma uva passa, comece a usar protetor solar!", "Se não quiser virar uma protetor solar, comece a usar uva passa!"]
}


