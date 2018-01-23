//
//  ViewController.swift
//  SwitchColorApp
//
//  Created by Akerke Okapova on 1/18/18.
//  Copyright © 2018 Akerke Okapova. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var background: UIView!
    @IBOutlet weak var switchOrdinaryButton: UIButton!
    
    @IBAction func switchColorButtonPressed(_ sender: Any) {
        switchOrdinaryButton.backgroundColor = getRandomColor()
    }
    
    @IBAction func switchRedColorButtonPressed(_ sender: Any) {
        background.backgroundColor = getShade(color: "red")
    }
    
    @IBAction func switchGreenColorButtonPressed(_ sender: Any) {
        background.backgroundColor = getShade(color: "green")
    }
    
    @IBAction func switchBlueColorButtonPressed(_ sender: Any) {
        background.backgroundColor = getShade(color: "blue")
    }
    
    private let colorRanges: [String: (Int, Int)] = [
        "red": (0, 18),
        "green": (63, 178),
        "blue": (179, 257)
    ]
    
    func getShade(color: String) -> UIColor {
        let hue = CGFloat(Float(getRandomInt(mn: (colorRanges[color]?.0)!, mx: (colorRanges[color]?.1)!)) / 360.0)
        
        return UIColor(hue: hue, saturation: 0.66, brightness: 0.66, alpha: 1.0)
    }
    
    func getRandomInt(mn: Int, mx: Int) -> Int {
        return Int(arc4random_uniform(UInt32(mx - mn))) + mn
    }
    
    func getRandomColor() -> UIColor {
        let red = CGFloat(drand48())
        let green = CGFloat(drand48())
        let blue = CGFloat(drand48())
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        background.backgroundColor = getRandomColor()
    }

}

