//
//  ViewController.swift
//  SwitchColorApp
//
//  Created by Akerke Okapova on 1/18/18.
//  Copyright © 2018 Akerke Okapova. All rights reserved.
//

import UIKit
private struct Constants{
    
    static let blueColor = UIColor(red: 47/255, green: 131/255, blue: 170/255, alpha: 1.0)
    static let redColor = UIColor(red: 206/255, green: 64/255, blue: 92/255, alpha: 1.0)
}

class ViewController: UIViewController {
    
    @IBOutlet var background: UIView!
    @IBOutlet weak var switchOrdinaryButton: UIButton!
    @IBAction func switchColorButtonPressed(_ sender: Any) {
        changeColor()
    }
    
    func changeColor(){
        let backgroundColor = background.backgroundColor?.cgColor
        let buttonColor =
            UIColor(cgColor: switchOrdinaryButton.layer.backgroundColor!)
        
        background.backgroundColor = buttonColor
        
        switchOrdinaryButton.layer.backgroundColor = backgroundColor
        switchOrdinaryButton.layer.borderColor = backgroundColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switchOrdinaryButton.layer.cornerRadius = 10
        switchOrdinaryButton.layer.borderWidth = 10
        
        switchOrdinaryButton.layer.backgroundColor = Constants.blueColor.cgColor
        switchOrdinaryButton.layer.borderColor = Constants.blueColor.cgColor
        
        background.backgroundColor = Constants.redColor
    }
    
}

