//
//  LevelModel.swift
//  BinaryGameMenu
//
//  Created by Ahdan Amanullah on 29/04/24.
//
import SwiftData
import Foundation

@Model
class LevelData {
    @Attribute(.unique) let number: Int
    var score: Int
    var unlocked: Bool
    var completed: Bool
    let topGradient: String
    let bottomGradient: String
    
    init(number: Int, score: Int, unlocked: Bool, completed: Bool, topGradient: String, bottomGradient: String) {
        self.number = number
        self.score = score
        self.unlocked = unlocked
        self.completed = completed
        self.topGradient = topGradient
        self.bottomGradient = bottomGradient
    }
}

