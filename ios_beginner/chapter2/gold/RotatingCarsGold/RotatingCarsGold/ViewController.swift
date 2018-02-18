//
//  ViewController.swift
//  RotatingCarsGold
//
//  Created by Akerke Okapova on 2/18/18.
//  Copyright © 2018 Akerke Okapova. All rights reserved.
//

import UIKit

struct Constants {
    
    static let images = [ #imageLiteral(resourceName: "car-1"), #imageLiteral(resourceName: "car-2"), #imageLiteral(resourceName: "car-3"), #imageLiteral(resourceName: "car-4") ]
    static let direction = ["Up", "Down"]
}

struct Rotation{
    
    var interval: TimeInterval = 1
    var direction = 0
}

class ViewController: UIViewController {

    @IBOutlet weak var firstImageView: UIImageView!
    @IBOutlet weak var secondImageView: UIImageView!
    @IBOutlet weak var thirdImageView: UIImageView!
    @IBOutlet weak var fourthImageView: UIImageView!
    
    @IBOutlet weak var currentIntervalLabel: UILabel!
    @IBOutlet weak var currentDirectionLabel: UILabel!
    
    @IBOutlet weak var intervalLabel: UILabel!
    
    @IBOutlet weak var applyButton: UIButton!
   
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    
    @IBAction func stepperChanged(_ sender: UIStepper) {
        intervalLabel.text = Int(sender.value).description
    }
    
    private var rotation = Rotation()
    var timer: Timer?
    
    @IBAction func applyButtonPressed(_ sender: Any) {
        startRotating()
    }
    
    func startRotating(){
        timer?.invalidate()
        rotation.interval = TimeInterval(Int(intervalLabel.text!)!)
        rotation.direction = segmentedControl.selectedSegmentIndex
        
        currentIntervalLabel.text = "Current interval: \(Int(rotation.interval))"
        currentDirectionLabel.text = "Current direction: \(Constants.direction[rotation.direction])"
        
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(rotation.interval), target: self, selector: #selector(rotate), userInfo: nil, repeats: true)
    }
    
    func getIndex(_ i: Int, _ m: Int) -> Int {
        return (i + m) % m;
    }
    
    @objc func rotate(){
        var imageViews = [firstImageView, secondImageView, thirdImageView, fourthImageView]
        let numberOfImages = imageViews.count
        var step = 0, index = 0
        switch rotation.direction{
        case 0:
            step = -1
            index = numberOfImages
        case 1:
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
        applyButton.layer.cornerRadius = 5
        stepper.minimumValue = 1
        stepper.maximumValue = 10
        for i in 0...Constants.direction.count - 1 {
            segmentedControl.setTitle(Constants.direction[i], forSegmentAt: i)
        }
        startRotating()
    }
}

