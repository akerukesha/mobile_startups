//
//  ViewController.swift
//  SpyDetector
//
//  Created by Akerke Okapova on 4/26/18.
//  Copyright © 2018 Akerke Okapova. All rights reserved.
//

import UIKit

extension Constants {
    
    static let showResultsSegue = "ShowResults"
}

class ViewController: UIViewController {

    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var rightView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var statusImageview: UIImageView!
    @IBOutlet weak var timerLabel: UILabel!
    
    
    var game: Game! {
        didSet{
            updateUI()
        }
    }
    
    @IBAction func noButtonPressed(_ sender: Any) {
        
        showAnswer(false)
    }
    
    @IBAction func yesButtonPressed(_ sender: Any) {
        
        showAnswer(true)
    }
    
    func showAnswer(_ answer: Bool) {
        game?.totalRounds += 1
        statusImageview.isHidden = false
        if game.check(answer: answer){
            statusImageview?.image = Constants.successImage
            game?.rightAnswerCnt += 1
        }else{
            statusImageview?.image = Constants.failImage
            game?.wrongAnswerCnt += 1
        }
        browseNewGame()
    }
    
    @objc func decreaseSeconds() {
        game?.decrementSeconds()
        
        timerLabel?.text = "\(game.seconds / 60 < 10 ? "0" : "")\(game.seconds / 60):\(game.seconds % 60 < 10 ? "0" : "")\(game.seconds % 60)"
        
        if game.seconds == 0{
            gameManager.addGame(game)
            game.timer.invalidate()
            performSegue(withIdentifier: Constants.showResultsSegue, sender: game)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier!{
        case Constants.showResultsSegue:
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.game = sender as! Game
        default:
            break
        }
    }
    
    func updateUI() {
        
        //timerLabel?.text = "\(Constants.gameMinutes < 10 ? "0" : "")\(Constants.gameMinutes):\(Constants.gameSeconds < 10 ? "0" : "")\(Constants.gameSeconds)"
        //game?.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(decreaseSeconds), userInfo: nil, repeats: true)
        leftView?.layer.cornerRadius = 8
        leftView?.layer.shadowOpacity = 0.5
        leftView?.layer.shadowOffset = CGSize(width: 0, height: 2)
        leftView?.layer.shadowRadius = 10
        leftView?.layer.shadowColor = UIColor.black.cgColor
        
        rightView?.layer.cornerRadius = 8
        rightView?.layer.shadowOpacity = 0.5
        rightView?.layer.shadowOffset = CGSize(width: 0, height: 2)
        rightView?.layer.shadowRadius = 10
        rightView?.layer.shadowColor = UIColor.black.cgColor
    }
    
    func browseNewGame() {
        
//        statusImageview?.isHidden = true
        game?.newRound()
        titleLabel?.textColor = Constants.colors[game.leftColorIndex]
        titleLabel?.text = Constants.titles[game.leftTitleIndex]
        
        colorLabel?.textColor = Constants.colors[game.rightColorIndex]
        colorLabel?.text = Constants.titles[game.rightTitleIndex]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        game?.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(decreaseSeconds), userInfo: nil, repeats: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timerLabel?.text = "\(Constants.gameMinutes < 10 ? "0" : "")\(Constants.gameMinutes):\(Constants.gameSeconds < 10 ? "0" : "")\(Constants.gameSeconds)"
        updateUI()
        browseNewGame()
    }
}

