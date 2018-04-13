//
//  Difficulty.swift
//  MemoryGame
//
//  Created by Assaf Tayouri on 01/04/2018.
//  Copyright © 2018 Assaf Tayouri. All rights reserved.
//

import Foundation

enum Difficulty {
    case Easy
    case Medium
    case Hard
    
    func getSecRow() -> (Int,Int) {
        switch self {
        case .Easy:
            return (4,3)
        case .Medium:
            return (4,4)
        case .Hard:
            return (4,5)
        }
    }
    static func getDifficultyBy(difficultyname:String)->Difficulty{
        switch difficultyname {
        case "Easy":
            return .Easy
        case "Medium":
            return .Medium
        case "Hard":
            return .Hard
        default:
            return .Easy
        }
    }
}
