//
//  ViewController.swift
//  QuizApp
//
//  Created by Akerke Okapova on 2/19/18.
//  Copyright © 2018 Akerke Okapova. All rights reserved.
//

import UIKit

struct Constants{
    
    static let questions = [
        (index: "1", question: "Кто является создателем социальной сети Facebook?", options: ["zuckerberg", "gates", "musk", "durov"]),
        (index: "2", question: "Какой мессенджер является самым популярным в мире?", options: ["telegram", "messenger", "whatsapp", "talk"]),
        (index: "3", question: "Какой из предложенных логотипов принадлежит файлообменнику?", options: ["apple", "dropbox", "huawei", "evernote"])
    ]
    
    static let answers = ["zuckerberg", "whatsapp", "dropbox"]
}

struct Game{
    
    private var score = 0
    private var index = 0
    private var state = false
    
    mutating func reset(){
        score = 0
        index = 0
        state = false
    }
    
    mutating func increaseScore(){
        score += 1
    }
    
    mutating func increaseIndex(){
        index += 1
    }
    
    mutating func changeState(){
        state = state ? false : true
    }
    
    var total: Int{
        return score
    }
    
    var currentIndex: Int{
        return index
    }
    
    var optionIsChosen: Bool{
        return state
    }
    
    func getNextQuestion(){
        
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var optionButtonsStackView: UIStackView!
    @IBOutlet weak var questionIndexLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var optionOneButton: UIButton!
    @IBOutlet weak var optionTwoButton: UIButton!
    @IBOutlet weak var optionThreeButton: UIButton!
    @IBOutlet weak var optionFourButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    
    private var game = Game()
    
    func getQuestion(){
        questionIndexLabel.text = "Вопрос #\(Constants.questions[game.currentIndex].index)"
        questionLabel.text = "\(Constants.questions[game.currentIndex].question)"
        optionOneButton.setBackgroundImage(UIImage(named: Constants.questions[game.currentIndex].options[0]) , for: .normal)
        optionTwoButton.setBackgroundImage(UIImage(named: Constants.questions[game.currentIndex].options[1]) , for: .normal)
        optionThreeButton.setBackgroundImage(UIImage(named: Constants.questions[game.currentIndex].options[2]) , for: .normal)
        optionFourButton.setBackgroundImage(UIImage(named: Constants.questions[game.currentIndex].options[3]) , for: .normal)
    }
    
    func clicked(){
        submitButton.isEnabled = true
        submitButton.setTitle("Продолжить", for: .normal)
        optionOneButton.isEnabled = false
        optionTwoButton.isEnabled = false
        optionThreeButton.isEnabled = false
        optionFourButton.isEnabled = false
    }
    
    @IBAction func optionButtonPressed(_ sender: UIButton) {
        sender.layer.borderWidth = 3
        if(Constants.questions[game.currentIndex].options[sender.tag] == Constants.answers[game.currentIndex]){
            sender.layer.borderColor = UIColor.green.cgColor
            game.increaseScore()
        }else{
            sender.layer.borderColor = UIColor.red.cgColor
        }
        clicked()
    }
    
    func showAlert(alertTitle: String, alertMessage: String) {
        
        let alertView = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "Ок", style: .default, handler: {(action) in
            self.game.reset()
            self.getQuestion()
        }))
        present(alertView, animated:true, completion:nil)
    }
    
    func clear(){
        submitButton.isEnabled = false
        submitButton.setTitle("Выберите вариант", for: .normal)
        optionOneButton.layer.borderWidth = 0
        optionOneButton.layer.borderColor = UIColor.clear.cgColor
        optionOneButton.isEnabled = true
        optionTwoButton.layer.borderWidth = 0
        optionTwoButton.layer.borderColor = UIColor.clear.cgColor
        optionTwoButton.isEnabled = true
        optionThreeButton.layer.borderWidth = 0
        optionThreeButton.layer.borderColor = UIColor.clear.cgColor
        optionThreeButton.isEnabled = true
        optionFourButton.layer.borderWidth = 0
        optionFourButton.layer.borderColor = UIColor.clear.cgColor
        optionFourButton.isEnabled = true
    }
    
    @IBAction func submitButtonPressed(_ sender: Any) {
        clear()
        if(game.currentIndex < Constants.questions.count - 1){
            game.increaseIndex()
            getQuestion()
        }else{
            showAlert(alertTitle: "Финиш", alertMessage: "Ваш результат: \(game.total)")
        }
    }
    
//    func updateUI(){
//        if(game.optionIsChosen){
//            clicked()
//        }else{
//            clear()
//        }
//        game.changeState()
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        optionOneButton.layer.cornerRadius = 8
        optionTwoButton.layer.cornerRadius = 8
        optionThreeButton.layer.cornerRadius = 8
        optionFourButton.layer.cornerRadius = 8
        optionOneButton.layer.masksToBounds = true
        optionTwoButton.layer.masksToBounds = true
        optionThreeButton.layer.masksToBounds = true
        optionFourButton.layer.masksToBounds = true
        
        clear()
        getQuestion()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if(UIDevice.current.orientation.isLandscape){
            optionButtonsStackView.axis = .horizontal
        }else{
            optionButtonsStackView.axis = .vertical
        }
    }
}

