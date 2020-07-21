//
//  GameViewController.swift
//  EggsToss
//
//  Created by Akerke Okapova on 4/26/18.
//  Copyright © 2018 Akerke Okapova. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var eggImageView: UIImageView!
    @IBOutlet weak var brokenEggImageView: UIImageView!
    @IBOutlet weak var basketImageView: UIImageView!
    @IBOutlet weak var eggBackgroundView: UIView!
    @IBOutlet weak var gameOverView: UIView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var buttonStackView: UIStackView!
    
    var eggPosition = 0
    var basketPosition = 1
    
    var timer = Timer()
    var timerInterval:TimeInterval = 0.1
    var lives = 5
    var score = 0
    var superEggIsThrown = 0
    var level = 0
    var basketHeight: CGFloat = 390
    
    @IBAction func changePositionButtonPressed(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            basketPosition = 0
            basketImageView.frame.origin.x = 26
        case 1:
            basketPosition = 1
            basketImageView.frame.origin.x = 119
        case 2:
            basketPosition = 2
            basketImageView.frame.origin.x = 214
        default:
            basketPosition = 1
            basketImageView.frame.origin.x = 119
        }
    }
    
    @IBAction func restartButtonPressed(_ sender: UIButton) {
        gameOverView.isHidden = true
        buttonStackView.isHidden = false
        score = 0
        lives = 5
        
//        for case let imageView as UIImageView in eggBackgroundView.subviews{
//            imageView.image = UIImage(named: "egg")
//
//        }
        timerInterval = 0.1
        eggImageView.isHidden = false
        brokenEggImageView.isHidden = true
        throwEgg()
    }
    
    func getInitialPosition(){
        eggPosition = Int(arc4random_uniform(3))
        
        switch eggPosition{
        case 0:
            eggImageView.frame.origin.x = 81
        case 1:
            eggImageView.frame.origin.x = 174
        case 2:
            eggImageView.frame.origin.x = 268
        default:
            eggImageView.frame.origin.x = 174
            
        }
        eggImageView.frame.origin.y = 0
    }
    
    func showBrokenEgg(position: Int){
        switch eggPosition{
        case 0:
            brokenEggImageView.frame.origin.x = 61
        case 1:
            brokenEggImageView.frame.origin.x = 154
        case 2:
            brokenEggImageView.frame.origin.x = 248
        default:
            brokenEggImageView.frame.origin.x = 154
            
        }
        brokenEggImageView.isHidden = false
    }
    
    func checkEgg(){
        if eggImageView.frame.origin.y >= basketHeight{
            if eggPosition == basketPosition{
                score += 1
                if score % 5 == 0{
                    timerInterval /= 2
                }
                if superEggIsThrown == 1{
                    lives = min(lives + 1, 5)
                }
                timer.invalidate()
                throwEgg()
            }else{
                if eggImageView.frame.origin.y >= basketHeight + 100{
                    showBrokenEgg(position: eggPosition)
                    lives -= 1
                    updateLife()
                    timer.invalidate()
                    throwEgg()
                }
            }
        }
    }
    
    @objc func changePosition(){
        eggImageView.frame.origin.y += 5
        checkEgg()
    }
    
    func throwEgg(){
        if lives > 0{
            updateLife()
            superEggIsThrown = Int(arc4random()) % 2
            if superEggIsThrown == 1 {
                eggImageView.image = UIImage(named: "superEgg")
            }else{
                eggImageView.image = UIImage(named: "egg-flying")
            }
            getInitialPosition()
            timer = Timer.scheduledTimer(timeInterval: timerInterval, target: self, selector: #selector(changePosition), userInfo: nil, repeats: true)
        }else{
            gameOver()
        }
    }
    
    func updateLife(){
        for case let (index, imageView as UIImageView) in eggBackgroundView.subviews.enumerated(){
            if 4 - index >= lives {
                imageView.image = UIImage(named: "egg-broken")
            }else{
                imageView.image = UIImage(named: "egg")
            }
            
        }
    }
    
    func gameOver(){
        gameOverView.isHidden = false
        scoreLabel.text = "\(score)"
        buttonStackView.isHidden = true
        eggImageView.isHidden = true
    }
    
    func configureBasket(){
        switch level {
        case 0:
            basketHeight = 390
        case 1:
            basketHeight = 290
        case 2:
            basketHeight = 190
        default:
            basketHeight = 390
        }
        brokenEggImageView.frame.origin.y = basketHeight + 100
        basketImageView.frame.origin.y = basketHeight
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBasket()
        throwEgg()
    }
    
}
