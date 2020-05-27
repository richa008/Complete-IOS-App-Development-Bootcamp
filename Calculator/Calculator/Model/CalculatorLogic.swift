//
//  CalculatorLogic.swift
//  Calculator
//
//  Created by Richa Deshmukh on 5/26/20.
//  Copyright © 2020 London App Brewery. All rights reserved.
//

import Foundation

struct CalculatorLogic {
    
    private var number: Double?
    
    private var intermediateCalculation: (n1: Double, calcMethod: String)?
    
    mutating func calculate(symbol: String, n: Double) -> Double? {
        
        switch symbol {
        case "+/-":
            return n * -1
        case "AC":
            return 0
        case "%":
            return n * 0.01
        case "=":
            return performTwoNumCalculation(n2: n)
        default:
            intermediateCalculation = (n1: n, calcMethod: symbol)
        }
        return nil
    }
    
    private func performTwoNumCalculation(n2: Double) -> Double? {
        
        if let n1 = intermediateCalculation?.n1,
            let operation = intermediateCalculation?.calcMethod {
            
            switch operation {
            case "+":
                return n1 + n2
            case "-":
                return n1 - n2
            case "×":
                return n1 * n2
            case "÷":
                return n1 / n2
            default:
                fatalError("The operation passed in does not match any of the cases.")
            }
        }
        return nil
    }
}
