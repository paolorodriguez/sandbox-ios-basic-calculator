//
//  ViewController.swift
//  Test Calculator
//
//  Created by Paolo Rodríguez on 16/08/2017.
//  Copyright © 2017 Paolo Rodríguez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private enum ButtonType {
        case number(Int)
        case operation(String)
        case control(String)
    }
    
    private let tagToDigitValue = [
        100: 0,
        101: 1,
        102: 2,
        103: 3,
        104: 4,
        105: 5,
        106: 6,
        107: 7,
        108: 8,
        109: 9
    ]
    
    private let tagToOperation = [
        300: "null",
        301: "add",
        302: "subtract",
        303: "multiply",
        304: "divide"
    ]
    
    private let uiTagToFunctionMap = [
        200: ButtonType.control("decimal"),
        300: ButtonType.operation("null"),
        
        901: ButtonType.control("clear"),
        902: ButtonType.control("cancelEntry")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private var buffer: Double = 0
    private var entryInProgress = false
    
    @IBAction func enterDigit(_ sender: UIButton) {
        if let digitValue = tagToDigitValue[sender.tag] {
            if !entryInProgress {
                buffer = 0
                entryInProgress = true
            }
            buffer = (buffer * 10) + Double(digitValue)
            print(buffer)
        }
    }
    
    private var calculator: Model = Model()
    
    @IBAction func performOperation(_ sender: UIButton) {
        if let operation = tagToOperation[sender.tag] {
            entryInProgress = false
            calculator.setOperand(buffer)
            if let result = calculator.performOperation(operation) {
                print(result)
            }
            
        }
        
    }
    
}
