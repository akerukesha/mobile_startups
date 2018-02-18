//
//  ViewController.swift
//  RotatingCars
//
//  Created by Akerke Okapova on 2/18/18.
//  Copyright © 2018 Akerke Okapova. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var middleImageView: UIImageView!
    @IBOutlet weak var bottomImageView: UIImageView!
    @IBOutlet weak var rotateCarsButton: UIButton!
    @IBAction func onRotateCarsButtonPressed(_ sender: Any) {
        let topImage = topImageView.image
        
        topImageView.image = middleImageView.image
        middleImageView.image = bottomImageView.image
        bottomImageView.image = topImage
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        rotateCarsButton.layer.cornerRadius = 30
    }
}

