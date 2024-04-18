//
//  WeekEnum.swift
//  Dandie
//
//  Created by Igor Bragança Toledo on 17/04/24.
//

import Foundation

//Enum que guarda os dias da semana usados no WeekPicker 
enum DayOfWeek: Int, CaseIterable {
    case Domingo = 1,
         Segunda = 2,
         Terça = 3,
         Quarta = 4,
         Quinta = 5,
         Sexta = 6,
         Sabado = 7
    
    func name() -> String {
        switch self {
        case .Domingo: return "D"
        case .Segunda: return "S"
        case .Terça: return "T"
        case .Quarta: return "Q"
        case .Quinta: return "Q"
        case .Sexta: return "S"
        case .Sabado: return "S"
        }
    }
}
