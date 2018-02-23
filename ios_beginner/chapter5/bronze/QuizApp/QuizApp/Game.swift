//
//  Game.swift
//  QuizApp
//
//  Created by Akerke Okapova on 2/22/18.
//  Copyright © 2018 Akerke Okapova. All rights reserved.
//

import Foundation

struct Constants{
    
    static let questions = [
        (index: "1", question: "Кто является создателем социальной сети Facebook?", options: ["zuckerberg", "gates", "musk", "durov"]),
        (index: "2", question: "Какой мессенджер является самым популярным в мире?", options: ["telegram", "messenger", "whatsapp", "talk"]),
        (index: "3", question: "Какой из предложенных логотипов принадлежит файлообменнику?", options: ["apple", "dropbox", "huawei", "evernote"]),
        (index: "4", question: "Выберите лишнее.", options: ["ipad", "iphone", "macbook", "samsung"]),
        (index: "5", question: "Какой из продуктов не принадлежит компании Coca-Cola?", options: ["sprite", "7up", "fanta", "dasani"]),
    ]
    
    static let answers = ["zuckerberg", "whatsapp", "dropbox", "samsung", "7up"]
}

struct Game{
    
    private var score = 0
    private var index = 0
    private var state = true
    var time = 0
    
    mutating func reset() {
        score = 0
        index = 0
        state = true
        time = 0
    }
    
    var isAnswered: Bool {
        return state
    }
    
    mutating func getResults() -> (cntRight: Int, cntWrong: Int, time: Int){
        return (score, Constants.questions.count - score, time)
    }
    
    private mutating func changeState() {
        state = state ? false : true
    }
    
    mutating func incrementTime(){
        time += 1
    }
    
    mutating func checkAnswer(answerIndex: Int) -> Bool {
        let isRight = Constants.questions[index].options[answerIndex] == Constants.answers[index]
        if isRight == true {
            score += 1
        }
        changeState()
        index += 1
        return isRight
    }
    
    mutating func getNextQuestion() -> (index: Int, question: String, options: [String])? {
        changeState()
        if index == Constants.questions.count{
            return nil
        }
        return (index, Constants.questions[index].question, Constants.questions[index].options)
    }
}
