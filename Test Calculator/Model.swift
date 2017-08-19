//
//  Model.swift
//  Test Calculator
//
//  Created by Paolo Rodríguez on 18/08/2017.
//  Copyright © 2017 Paolo Rodríguez. All rights reserved.
//

import Foundation

struct Model {
    
    private var register: Double = 0
    private var binaryOperation: ((Double, Double) -> Double)? = nil
    private var accumulator: Double = 0
    
    enum OperationType {
        case nullary(() -> Double)
        case unary((Double) -> Double)
        case binary(((Double, Double) -> Double)?)
    }
    
    let operations = [
        "pi" : OperationType.nullary({ Double.pi }),
        "e" : OperationType.nullary({ M_E }),
        "negate" : OperationType.unary({ -$0 }),
        "square" : OperationType.unary({ pow($0, 2) }),
        "squareRoot" : OperationType.unary({ sqrt($0) }),
        "add" : OperationType.binary({ $0 + $1 }),
        "subtract" : OperationType.binary({ $0 - $1 }),
        "multiply" : OperationType.binary({ $0 * $1 }),
        "divide" : OperationType.binary({ $0 / $1 }),
        "null" : OperationType.binary(nil)
    ]
    
    mutating func setOperand(_ operand: Double) {
        accumulator = operand
    }
    
    mutating func performOperation(_ operation: String) -> Double? {
        if let op = operations[operation] {
            switch op {
            case .nullary(let f):
                accumulator = f()
            case .unary(let f):
                accumulator = f(accumulator)
            case .binary(let f):
                if binaryOperation != nil {
                    accumulator = binaryOperation!(register, accumulator)
                }
                register = accumulator
                if f != nil {
                    binaryOperation = f
                }
            }
            return accumulator
        } else {
            return nil
        }
    }
    
}
