//
//  ResultViewController.swift
//  QuizAppGold
//
//  Created by Akerke Okapova on 2/22/18.
//  Copyright © 2018 Akerke Okapova. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var cntRightLabel: UILabel!
    @IBOutlet weak var cntWrongLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var game: Game! {
        didSet{
            updateUI()
        }
    }
    
    func updateUI(){
        if var game = game {
            let total = game.getResults()
            cntRightLabel?.text = "Количество правильных ответов: \(total.cntRight)"
            cntWrongLabel?.text = "Количество неправильных ответов: \(total.cntWrong)"
            timeLabel?.text = "Время прохождения: \(total.time)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
}
