//
//  ViewController.swift
//  EasyPaint
//
//  Created by Akerke Okapova on 4/26/18.
//  Copyright © 2018 Akerke Okapova. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tempImageView: UIImageView!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var brushSizeLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!
    
    var brushSize: CGFloat = 10
    var lastPoint = CGPoint.zero
    var swiped = false
    var brushColor: CGColor = UIColor.black.cgColor
    
    func drawLineFrom(fromPoint: CGPoint, toPoint: CGPoint) {
        UIGraphicsBeginImageContext(self.view.frame.size)
        let context = UIGraphicsGetCurrentContext()
        self.tempImageView.image?.draw(in: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        
        context?.move(to: fromPoint)
        context?.addLine(to: toPoint)
        
        context?.setLineCap(CGLineCap.round)
        context?.setLineWidth(self.brushSize)
        context?.setStrokeColor(brushColor)
        context?.setBlendMode(CGBlendMode.normal)
        
        context?.strokePath()
        
        self.tempImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        self.tempImageView.alpha = 1.0
        
        UIGraphicsEndImageContext()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.swiped = false
        
        if let touch = touches.first {
            self.lastPoint = touch.location(in: self.view)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.swiped = true
        
        if let touch = touches.first {
            let currentPoint = touch.location(in: self.view)
            self.drawLineFrom(fromPoint: self.lastPoint, toPoint: currentPoint)
            
            self.lastPoint = currentPoint
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !swiped {
            self.drawLineFrom(fromPoint: self.lastPoint, toPoint: self.lastPoint)
        }
        
        UIGraphicsBeginImageContext(self.mainImageView.frame.size)
        self.mainImageView.image?.draw(in: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height), blendMode: CGBlendMode.normal, alpha: 1.0)
        self.tempImageView.image?.draw(in: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height), blendMode: CGBlendMode.normal, alpha: 1.0)
        
        self.mainImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        print(view.frame.size)
        print(mainImageView.image?.size)
        print(lastPoint)
        print(brushSize)
        
        self.tempImageView.image = nil
    }
    @IBAction func minusButtonPressed(_ sender: Any) {
        self.brushSize -= max(self.brushSize - 1, 1)
        self.brushSizeLabel.text = "\(Int(self.brushSize))"
    }
    
    @IBAction func plusButtonPressed(_ sender: Any) {
        self.brushSize += 1
        self.brushSizeLabel.text = "\(Int(self.brushSize))"
    }
    
    @IBAction func refreshButtonPressed(_ sender: Any) {
        self.mainImageView.image = nil
    }
    
    @IBAction func redButtonPressed(_ sender: Any) {
        brushColor = UIColor.red.cgColor
    }
    
    @IBAction func blueButtonPressed(_ sender: Any) {
        brushColor = UIColor.blue.cgColor
    }
    
    @IBAction func blackButtonPressed(_ sender: Any) {
        brushColor = UIColor.black.cgColor
    }
    
    @IBAction func greenButtonPressed(_ sender: Any) {
        brushColor = UIColor.green.cgColor
    }
    
    @IBAction func eraserButtonPressed(_ sender: Any) {
        brushColor = UIColor.white.cgColor
    }
    
    @IBAction func shareButtonPressed(_ sender: Any) {
//        UIGraphicsBeginImageContextWithOptions(mainImageView.frame.size, false, 0.0)
//        mainImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
//        UIImageView(image: UIImage(named: "image.png")).layer.render(in: UIGraphicsGetCurrentContext()!)
//        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsBeginImageContext(view.frame.size)
        tempImageView.layer.render(in:UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let activityViewController = UIActivityViewController(activityItems:[image!], applicationActivities: [])
        if let popOverController = activityViewController.popoverPresentationController{
            popOverController.sourceView = self.view
            popOverController.sourceRect = self.view.bounds
        }
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.brushSizeLabel.text = "\(Int(self.brushSize))"
    }
}

