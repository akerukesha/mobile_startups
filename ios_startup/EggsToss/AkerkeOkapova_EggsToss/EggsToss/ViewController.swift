//
//  ViewController.swift
//  EggsToss
//
//  Created by Akerke Okapova on 4/26/18.
//  Copyright © 2018 Akerke Okapova. All rights reserved.
//

import UIKit

struct Constants {
    
    static let showNewGameSegue = "ShowNewGame"
}

class ViewController: UIViewController {
    
    var level = 0
    
    @IBOutlet weak var easyLevelButton: UIButton!
    @IBOutlet weak var mildLevelButton: UIButton!
    @IBOutlet weak var hardLevelButton: UIButton!
    
    @IBAction func newGameButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: Constants.showNewGameSegue, sender: level)
    }
    
    @IBAction func levelButtonPressed(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            level = 0
            easyLevelButton.layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6).cgColor
            mildLevelButton.layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
            hardLevelButton.layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
        case 1:
            level = 1
            easyLevelButton.layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
            mildLevelButton.layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6).cgColor
            hardLevelButton.layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
        case 2:
            level = 2
            easyLevelButton.layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
            mildLevelButton.layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
            hardLevelButton.layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6).cgColor
        default:
            level = 0
            easyLevelButton.layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6).cgColor
            mildLevelButton.layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
            hardLevelButton.layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case Constants.showNewGameSegue:
            let destinationVC = segue.destination as! GameViewController
            destinationVC.level = sender as! Int
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        level = 0
        easyLevelButton.layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6).cgColor
        mildLevelButton.layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
        hardLevelButton.layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
        // Do any additional setup after loading the view, typically from a nib.
    }
}

