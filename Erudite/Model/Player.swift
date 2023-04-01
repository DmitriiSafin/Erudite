//
//  Player.swift
//  Erudite
//
//  Created by Дмитрий on 25.11.2022.
//

import Foundation

struct Player {
    
    let name: String
    private(set) var score = 0
    
    mutating func add(score: Int) {
        self.score += score
    }
}
