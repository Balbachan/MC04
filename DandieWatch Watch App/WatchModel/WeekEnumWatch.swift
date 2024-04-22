//
//  WeekEnumWatch.swift
//  DandieWatch Watch App
//
//  Created by Igor Bragança Toledo on 22/04/24.
//

import Foundation

enum DayOfWeekOne: Int, CaseIterable {
    case Segunda = 1,
         Terça = 2,
         Quarta = 3
    
    func name() -> String {
        switch self {
        case .Segunda: return "S"
        case .Terça: return "T"
        case .Quarta: return "Q"
        }
    }
}

enum DayOfWeekTwo: Int, CaseIterable {
    case Quinta = 1,
         Sexta = 2,
         Sabado = 3,
         Domingo = 4
    
    func name() -> String {
        switch self {
        case .Quinta: return "Q"
        case .Sexta: return "S"
        case .Sabado: return "S"
        case .Domingo: return "D"
        }
    }
}
