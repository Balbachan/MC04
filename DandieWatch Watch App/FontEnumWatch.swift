//
//  FontsEnumWatch.swift
//  Dandie
//
//  Created by Igor Bragança Toledo on 12/04/24.
//

import Foundation

enum FontTypeWatch: CGFloat {
    case t1 = 40
    case t2 = 32
    case t3 = 24
    case t4 = 16
    case b1 = 20
    case b2 = 14
    
    var font: String {
        switch self {
            case .t1: "Digitalt"
            case .t2: "Digitalt"
            case .t3: "Digitalt"
            case .t4: "Digitalt"
            case .b1: "AssistantRoman-SemiBold"
            case .b2: "AssistantRoman-SemiBold"
        }
    }
}

