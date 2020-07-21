//
//  StartViewController.swift
//  SpyDetector
//
//  Created by Akerke Okapova on 4/26/18.
//  Copyright © 2018 Akerke Okapova. All rights reserved.
//

import UIKit

var gameManager = GameManager()

extension Constants {
    
    static let showNewGameSegue = "ShowNewGame"
}

class StartViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    
    @IBAction func newGameButtonPressed(_ sender: Any) {
        
        if let name = nameTextField.text {
            var game = Game()
            game.name = name
            performSegue(withIdentifier: Constants.showNewGameSegue, sender: game)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case Constants.showNewGameSegue:
            let destinationVC = segue.destination as! ViewController
            destinationVC.game = sender as! Game
        default:
            break
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
