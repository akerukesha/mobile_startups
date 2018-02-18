//
//  ViewController.swift
//  SwitchColorAppBronze
//
//  Created by Akerke Okapova on 2/18/18.
//  Copyright © 2018 Akerke Okapova. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var background: UIView!
    @IBOutlet weak var switchOrdinaryButton: UIButton!
    @IBAction func switchOrdinaryButtonPressed(_ sender: Any) {
        changeColor()
    }
    func getRandomColor() -> UIColor {
        let red = CGFloat(drand48())
        let green = CGFloat(drand48())
        let blue = CGFloat(drand48())
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    func changeColor(){
        background.backgroundColor = getRandomColor()
        let buttonColor = getRandomColor()
        switchOrdinaryButton.backgroundColor = buttonColor
        switchOrdinaryButton.layer.borderColor = buttonColor.cgColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switchOrdinaryButton.layer.cornerRadius = 10
        switchOrdinaryButton.layer.borderWidth = 10
        changeColor()
    }
}

