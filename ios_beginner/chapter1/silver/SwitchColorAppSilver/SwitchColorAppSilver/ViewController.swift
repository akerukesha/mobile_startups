//
//  ViewController.swift
//  SwitchColorApp
//
//  Created by Akerke Okapova on 1/18/18.
//  Copyright © 2018 Akerke Okapova. All rights reserved.
//

import UIKit

private struct Constants{
    
    static let greenColorKey = "green"
    static let blueColorKey = "blue"
    static let redColorKey = "red"
    static let colorRanges: [String: (Int, Int)] = [
        redColorKey: (0, 18),
        greenColorKey: (63, 178),
        blueColorKey: (179, 257)
    ]
}

class ViewController: UIViewController {
    
    @IBOutlet var background: UIView!
    @IBOutlet weak var switchOrdinaryButton: UIButton!
    @IBAction func switchColorButtonPressed(_ sender: Any) {
        changeColor()
    }
    
    func getShade(color: String) -> UIColor {
        let hue = CGFloat(Float(getRandomInt(mn: (Constants.colorRanges[color]?.0)!, mx: (Constants.colorRanges[color]?.1)!)) / 360.0)
        
        return UIColor(hue: hue, saturation: 0.66, brightness: 0.66, alpha: 1.0)
    }
    
    func getRandomInt(mn: Int, mx: Int) -> Int {
        return Int(arc4random_uniform(UInt32(mx - mn))) + mn
    }
    
    func changeColor(){
        background.backgroundColor = getShade(color: Constants.greenColorKey)
        
        let buttonColor = getShade(color: Constants.blueColorKey)
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

