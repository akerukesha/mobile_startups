//
//  GameManager.swift
//  SpyDetector
//
//  Created by Akerke Okapova on 4/26/18.
//  Copyright © 2018 Akerke Okapova. All rights reserved.
//

import Foundation

struct GameManager {
    
    var leaderboard: [Game] = []
    
    mutating func addGame(_ game: Game) {
        leaderboard.append(game)
        leaderboard.sort(by: {$0.rightAnswerCnt > $1.rightAnswerCnt})
    }
}
