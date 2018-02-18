//
//  ViewController.swift
//  RotatingCarsBronze
//
//  Created by Akerke Okapova on 2/18/18.
//  Copyright © 2018 Akerke Okapova. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var firstImageView: UIImageView!
    @IBOutlet weak var secondImageView: UIImageView!
    @IBOutlet weak var thirdImageView: UIImageView!
    @IBOutlet weak var fourthImageView: UIImageView!
    @IBOutlet weak var rotateCarsButton: UIButton!
    
    @IBAction func onRotateCarsButtonPressed(_ sender: Any) {
        let firstImage = firstImageView.image
        firstImageView.image = secondImageView.image
        secondImageView.image = thirdImageView.image
        thirdImageView.image = fourthImageView.image
        fourthImageView.image = firstImage
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rotateCarsButton.layer.cornerRadius = 20
    }
}

