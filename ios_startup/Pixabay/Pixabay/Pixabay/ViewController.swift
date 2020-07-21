//
//  ViewController.swift
//  Pixabay
//
//  Created by Akerke Okapova on 4/18/18.
//  Copyright © 2018 Akerke Okapova. All rights reserved.
//

import UIKit

extension Constants {
    
    static let buttonColor = UIColor(red: 122/255, green: 137/255, blue: 255/255, alpha: 1.0).cgColor
    
    static let mediaListIdentifier = "ShowMediaList"
}

class ViewController: UIViewController {

    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var favoritesButton: UIButton!
    
    var mediaManager = MediaManager()
    
    
    //better to merge into one function and work with dictionaries to get and assign modes
    
    @IBAction func searchButtonPressed(_ sender: Any) {
        mediaManager.setMode(mode: Constants.searchMode)
        self.performSegue(withIdentifier: Constants.mediaListIdentifier, sender: mediaManager)
    }
    
    @IBAction func favoritesButtonPressed(_ sender: Any) {
        mediaManager.setMode(mode: Constants.favoritesMode)
        self.performSegue(withIdentifier: Constants.mediaListIdentifier, sender: mediaManager)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case Constants.mediaListIdentifier:
            let destinationVC = segue.destination as! MediaListViewController
            destinationVC.mediaManager = sender as! MediaManager
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchButton.layer.borderColor = Constants.buttonColor
        searchButton.layer.borderWidth = 1
        
        favoritesButton.layer.borderColor = Constants.buttonColor
        favoritesButton.layer.borderWidth = 1
    }
}

