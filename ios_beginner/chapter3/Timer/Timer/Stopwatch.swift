//
//  Stopwatch.swift
//  Timer
//
//  Created by Akerke Okapova on 2/19/18.
//  Copyright © 2018 Akerke Okapova. All rights reserved.
//

import Foundation

struct Constants{
    
    private static let startKey = "Start"
    private static let pauseKey = "Pause"
    private static let resumeKey = "Resume"
    
    static let keys = [startKey, pauseKey, resumeKey]
    
    static let states = (
        reset: 0,
        running: 1,
        paused: 2
    )
}

struct Stopwatch {
    
    private var seconds = 0
    private var state = Constants.states.reset
    
    mutating func reset(){
        seconds = 0
        state = Constants.states.reset
    }
    
    mutating func pause(){
        state = Constants.states.paused
    }
    
    mutating func start(){
        state = Constants.states.running
    }
    
    mutating func incrementSeconds(){
        seconds += 1
    }
    
    var description: String {
        return String(format: "%02d", seconds / 60) + ":" + String(format: "%02d", seconds % 60)
    }
    
    var currentState: Int{
        return state
    }
}
