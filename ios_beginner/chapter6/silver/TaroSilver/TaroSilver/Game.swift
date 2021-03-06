//
//  Game.swift
//  TaroSilver
//
//  Created by Akerke Okapova on 2/20/18.
//  Copyright © 2018 Akerke Okapova. All rights reserved.
//

import Foundation

struct Constants {
    
    static let numberOfOptions = 45
    
    static let keys = ["СТАРТ", "СТОП", "РЕЗУЛЬТАТ"]
    
    static let states = (
        reset: 0,
        running: 1,
        stopped: 2
    )
}

struct Game {
    
    private var index = 0
    private var state = Constants.states.reset
    
    var currentState: Int {
        return state
    }
    
    mutating func reset() {
        index = 0
        state = Constants.states.reset
    }
    
    mutating func stop() {
        state = Constants.states.stopped
    }
    
    mutating func start() {
        state = Constants.states.running
    }
    
    mutating func getNextIndex() -> Int {
        index = index % Constants.numberOfOptions + 1
        return index
    }
}

