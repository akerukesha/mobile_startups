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
    
    @IBAction func switchColorButtonPressed(_ sender: Any) {
        background.backgroundColor = getRandomColor()
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

