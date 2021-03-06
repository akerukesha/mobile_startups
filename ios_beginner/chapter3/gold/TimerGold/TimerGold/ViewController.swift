//
//  ViewController.swift
//  TimerGold
//
//  Created by Akerke Okapova on 2/19/18.
//  Copyright © 2018 Akerke Okapova. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startPauseButton: UIButton!
    
    var timer = Timer()
    var stopwatch = Stopwatch()
    
    func updateUI(){
        timerLabel.text = stopwatch.description
    }
    
    @IBAction func onRestartButtonPressed(_ sender: Any) {
        timer.invalidate()
        stopwatch.reset()
        showStartPauseButton()
        startPauseButton.setTitle(Constants.keys[stopwatch.currentState], for: .normal)
        updateUI()
    }
    
    @IBAction func onStartPauseButtonPressed(_ sender: Any) {
        if(stopwatch.currentState == Constants.states.running){
            timer.invalidate()
            stopwatch.pause()
        }else{
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(decreaseSeconds), userInfo: nil, repeats: true)
            stopwatch.start()
        }
        startPauseButton.setTitle(Constants.keys[stopwatch.currentState], for: .normal)
    }
    
    func hideStartPauseButton(){
        startPauseButton.isEnabled = false
        startPauseButton.setTitleColor(UIColor.clear, for: .normal)
        startPauseButton.setBackgroundImage(nil, for: .normal)
    }
    
    func showStartPauseButton(){
        startPauseButton.isEnabled = true
        startPauseButton.setTitleColor(UIColor.white, for: .normal)
        startPauseButton.setBackgroundImage(#imageLiteral(resourceName: "button"), for: .normal)
    }
    
    @objc func decreaseSeconds(){
        updateUI()
        stopwatch.decrementSeconds()
        
        if(stopwatch.currentState == Constants.states.reset){
            timer.invalidate()
            startPauseButton.setTitle(Constants.keys[stopwatch.currentState], for: .normal)
            hideStartPauseButton()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
}

