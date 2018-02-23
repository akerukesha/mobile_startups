//
//  ViewController.swift
//  Calculator
//
//  Created by Akerke Okapova on 2/22/18.
//  Copyright © 2018 Akerke Okapova. All rights reserved.
//

import UIKit

var formatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.maximumSignificantDigits = 6
    return formatter
}()

class ViewController: UIViewController {

    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    private var brain = CalculatorBrain()
    private var userInTheMiddleOfTyping = false
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        let currentTextInDisplay = displayLabel.text!
        
        if brain.resultIsLast {
            brain = CalculatorBrain()
            descriptionLabel.text = ""
            userInTheMiddleOfTyping = false
        }
        
        if !userInTheMiddleOfTyping {
            displayLabel.text = digit
            
            userInTheMiddleOfTyping = true
        } else {
            
            if currentTextInDisplay == "0"{
                displayLabel.text = digit
            } else {
                displayLabel.text = currentTextInDisplay + digit
            }
        }
    }
    
    private var displayDescription: String {
        get { return displayLabel.text! }
        set { descriptionLabel.text = newValue }
    }
    
    private var displayValue: Double {
        get { return Double(displayLabel.text!)! }
        set { displayLabel.text = formatter.string(from: newValue as NSNumber!) }
    }
    
    @IBAction func performOperation(_ sender: UIButton) {
        if userInTheMiddleOfTyping {
            brain.setOperand(displayValue)
            userInTheMiddleOfTyping = false
        }
        
        if let symbol = sender.currentTitle {
            brain.performOperation(symbol)
            
            if let result = brain.result {
                displayValue = result
            }
            if let description = brain.description {
                displayDescription = description
            }
        }
    }
    
    @IBAction func makeDouble(_ sender: Any) {
        if brain.resultIsLast {
            brain = CalculatorBrain()
            displayLabel.text = "0"
            descriptionLabel.text = ""
            userInTheMiddleOfTyping = true
        }
        if displayLabel!.text!.contains(".") == false {
            let currentTextInDisplay = displayLabel.text!
            displayLabel.text = currentTextInDisplay + "."
        }
    }
    @IBAction func removeLastDigit(_ sender: Any) {
        if brain.resultIsLast {
            brain = CalculatorBrain()
            descriptionLabel.text = ""
            userInTheMiddleOfTyping = true
        }
        if displayLabel.text!.count == 1 {
            displayLabel.text = "0"
        }else{
            var curText = displayLabel.text!
            curText.removeLast()
            if curText.last == "."{
                curText.removeLast()
            }
            displayLabel.text = curText
        }
    }
}

