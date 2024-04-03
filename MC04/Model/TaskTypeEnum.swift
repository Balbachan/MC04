//
//  TaskTypeEnum.swift
//  MC04
//
//  Created by Laura C. Balbachan dos Santos on 02/04/24.
//

import Foundation

enum TaskType: String {
    case pele
    case barba
    case cabelo
    
    var desc: String {
        switch self {
            case .pele: return "PELE"
            case .barba: return "BARBA"
            case .cabelo: return "CABELO"
        }
    }
}
