//
//  GameViewController.swift
//  TaroGold
//
//  Created by Akerke Okapova on 2/20/18.
//  Copyright © 2018 Akerke Okapova. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var optionLabel: UILabel!
    @IBOutlet weak var startPauseButton: UIButton!
    
    var timer = Timer()
    var game: Game! {
        didSet{
            updateUI()
        }
    }
    
    func updateUI(){
        startPauseButton?.layer.borderWidth = 2
        startPauseButton?.layer.borderColor = UIColor.white.cgColor
        if var game = game {
            game.reset()
            startPauseButton?.setTitle(Constants.keys[game.currentState], for: .normal)
            headerLabel?.text = Constants.categoryNames[Constants.categories[game.currentCategory]]
        }
    }
    
    @objc func changeOption() {
        optionLabel?.text = game.getNextOption()
    }
    
    @IBAction func startPauseButtonPressed(_ sender: Any) {
        if(game.currentState == Constants.states.running){
            timer.invalidate()
            game.pause()
        }else{
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(changeOption), userInfo: nil, repeats: true)
            game.start()
        }
        startPauseButton.setTitle(Constants.keys[game.currentState], for: .normal)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
}
