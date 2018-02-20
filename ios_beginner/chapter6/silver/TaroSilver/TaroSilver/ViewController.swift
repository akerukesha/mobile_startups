//
//  ViewController.swift
//  TaroSilver
//
//  Created by Akerke Okapova on 2/20/18.
//  Copyright © 2018 Akerke Okapova. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var optionImageView: UIImageView!
    @IBOutlet weak var startPauseButton: UIButton!
    
    var timer = Timer()
    var game = Game()
    
    @objc func updateUI(){
        optionImageView?.image = UIImage(named:"\(game.getNextIndex()).jpg")
    }
    
    @IBAction func startPauseButtonPressed(_ sender: Any) {
        if(game.currentState == Constants.states.running){
            timer.invalidate()
            game.stop()
            startPauseButton.isEnabled = false
        }else{
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateUI), userInfo: nil, repeats: true)
            game.start()
        }
        startPauseButton.setTitle(Constants.keys[game.currentState], for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startPauseButton.layer.borderWidth = 2
        startPauseButton.layer.borderColor = UIColor.white.cgColor
        game.reset()
        startPauseButton.setTitle(Constants.keys[game.currentState], for: .normal)
//        updateUI()
    }
}

