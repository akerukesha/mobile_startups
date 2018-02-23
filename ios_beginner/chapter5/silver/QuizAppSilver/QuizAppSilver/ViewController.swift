//
//  ViewController.swift
//  QuizAppSilver
//
//  Created by Akerke Okapova on 2/22/18.
//  Copyright © 2018 Akerke Okapova. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var optionButtonStackView: UIStackView!
    @IBOutlet weak var optionOneButton: UIButton!
    @IBOutlet weak var optionTwoButton: UIButton!
    @IBOutlet weak var optionThreeButton: UIButton!
    @IBOutlet weak var optionFourButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var questionIndexLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    
    private var game = Game()
    private var timer = Timer()
    
    func showQuestion(_ index: Int, _ question: String, _ options: [String]){
        clear()
        questionIndexLabel.text = "Вопрос #\(index + 1)"
        questionLabel.text = "\(question)"
        optionOneButton.setBackgroundImage(UIImage(named: options[0]) , for: .normal)
        optionTwoButton.setBackgroundImage(UIImage(named: options[1]) , for: .normal)
        optionThreeButton.setBackgroundImage(UIImage(named: options[2]) , for: .normal)
        optionFourButton.setBackgroundImage(UIImage(named: options[3]) , for: .normal)
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
        print("tag: \(sender.tag)")
        if !game.isAnswered{
            clicked()
            sender.layer.borderWidth = 3
            if game.checkAnswer(answerIndex: sender.tag) == true {
                sender.layer.borderColor = UIColor.green.cgColor
            }else{
                sender.layer.borderColor = UIColor.red.cgColor
            }
        }

    }
    
    func showAlert(alertTitle: String, alertMessage: String) {
        
        let alertView = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "Ок", style: .default, handler: {(action) in
            self.game.reset()
            self.browseQuestion()
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
        if game.isAnswered{
            browseQuestion()
        }
    }
    
    func finish(){
        timer.invalidate()
        let total = game.getResults()
        
        let message = "Количество правильных ответов: \(total.cntRight)\nКоличество неправильных ответов: \(total.cntWrong)\nВремя прохождения:\(total.time)"
        
        showAlert(alertTitle: "Финиш", alertMessage: message)
    }
    
    func browseQuestion() {
        if let round = game.getNextQuestion() {
            if round.index == 0{
                timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(increaseSeconds), userInfo: nil, repeats: true)
            }
            showQuestion(round.index, round.question, round.options)
        }else{
            finish()
        }
    }
    
    @objc func increaseSeconds() {
        game.incrementTime()
        print("time: \(game.time)")
    }
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
        browseQuestion()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if(UIDevice.current.orientation.isLandscape){
            optionButtonStackView.axis = .horizontal
        }else{
            optionButtonStackView.axis = .vertical
        }
    }
}

