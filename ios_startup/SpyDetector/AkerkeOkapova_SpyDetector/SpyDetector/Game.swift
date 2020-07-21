//
//  Game.swift
//  SpyDetector
//
//  Created by Akerke Okapova on 4/26/18.
//  Copyright © 2018 Akerke Okapova. All rights reserved.
//

import Foundation

import UIKit

struct Constants {
    
    static let colors = [UIColor.black, UIColor.purple, UIColor.green, UIColor.orange, UIColor.red, UIColor.cyan, UIColor.brown, UIColor.gray]
    
    static let titles = ["Black", "Purple", "Green", "Orange", "Red", "Cyan", "Brown", "Gray"]
    
    static let failImage = #imageLiteral(resourceName: "fail")
    static let successImage = #imageLiteral(resourceName: "success")
    
    static let gameMinutes = 0
    static let gameSeconds = 10
    
}

struct Game {
    
    var name = ""
    
    var rightAnswerCnt = 0
    var wrongAnswerCnt = 0
    var totalRounds = 0
    
    var leftColorIndex = 0
    var leftTitleIndex = 0
    
    var rightColorIndex = 0
    var rightTitleIndex = 0
    
    var seconds = Constants.gameMinutes * 60 + Constants.gameSeconds
    
    var timer = Timer()
    
    mutating func decrementSeconds(){
        seconds -= 1
    }
    
    mutating func newRound() {
        
        leftColorIndex = Int(arc4random_uniform(UInt32(Constants.colors.count)))
        leftTitleIndex = Int(arc4random_uniform(UInt32(Constants.titles.count)))
        
        rightColorIndex = Int(arc4random_uniform(UInt32(Constants.colors.count)))
        rightTitleIndex = Int(arc4random_uniform(UInt32(Constants.titles.count)))
    }
    
    func check(answer: Bool) -> Bool {
        return (leftTitleIndex == rightColorIndex) == answer
    }
}
