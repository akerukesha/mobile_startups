//
//  ViewController.swift
//  RotatingCarsSilver
//
//  Created by Akerke Okapova on 2/18/18.
//  Copyright © 2018 Akerke Okapova. All rights reserved.
//

import UIKit

private struct Constants{
    
    static let upDirectionKey = "up"
    static let downDirectionKey = "down"
}

class ViewController: UIViewController {

    @IBOutlet weak var firstImageView: UIImageView!
    @IBOutlet weak var secondImageView: UIImageView!
    @IBOutlet weak var thirdImageView: UIImageView!
    @IBOutlet weak var fourthImageView: UIImageView!
    @IBOutlet weak var rotateUpButton: UIButton!
    @IBOutlet weak var rotateDownButton: UIButton!
    
    @IBAction func onRotateUpButtonPressed(_ sender: Any) {
        rotate(direction: Constants.upDirectionKey)
    }
    @IBAction func onRotateDownButtonPressed(_ sender: Any) {
        rotate(direction: Constants.downDirectionKey)
    }
    
    func getIndex(_ i: Int, _ m: Int) -> Int {
        return (i + m) % m;
    }
    
    func rotate(direction: String){
        var imageViews = [firstImageView, secondImageView, thirdImageView, fourthImageView]
        let numberOfImages = imageViews.count
        var step = 0, index = 0
        switch direction{
        case Constants.upDirectionKey:
            step = -1
            index = numberOfImages
        case Constants.downDirectionKey:
            step = 1
            index = 0
        default:
            break
        }
        var pendingImage = imageViews[0]?.image
        for _ in 0...numberOfImages - 1 {
            
            index = getIndex(index + step, numberOfImages)
            let currentImage = imageViews[index]?.image
            imageViews[index]?.image = pendingImage
            pendingImage = currentImage
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rotateUpButton.layer.cornerRadius = 20
        rotateDownButton.layer.cornerRadius = 20
    }
}

