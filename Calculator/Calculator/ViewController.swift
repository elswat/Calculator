//
//  ViewController.swift
//  Calculator
//
//  Created by Ahsoka Tano on 7/6/15.
//  Copyright (c) 2015 Ahsoka Tano. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTypingANumber = false
    var userHitDecimalPoint = false
    
    var brain = CalculatorBrain()
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            display.text = display.text! + digit
        } else {
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
        
    }
    
    @IBAction func decimalPoint(sender: UIButton) {
        let decimal = sender.currentTitle!
        if userHitDecimalPoint {
            display.text = display.text!
        } else {
            if userIsInTheMiddleOfTypingANumber {
                display.text = display.text! + decimal
                userHitDecimalPoint = true
            } else {
                display.text = decimal
                userHitDecimalPoint = true
                userIsInTheMiddleOfTypingANumber = true
            }
            
        }
    }
    
    @IBAction func operate(sender: UIButton) {
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        if let operation = sender.currentTitle {
            if let result = brain.performOperation(operation) {
                displayValue = result
            } else {
                displayValue = 0
            }
        }
    }
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        userHitDecimalPoint = false
        if let result = brain.pushOperand(displayValue) {
            displayValue = result
        } else {
            displayValue = 0
        }
    }
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
            userHitDecimalPoint = false
        }
    }
}

