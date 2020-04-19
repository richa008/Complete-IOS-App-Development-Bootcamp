//
//  BmiModel.swift
//  BMI Calculator
//
//  Created by Richa Deshmukh on 4/18/20.
//  Copyright © 2020 Angela Yu. All rights reserved.
//

import UIKit

struct BmiModel {
    
    var bmiValue: Float?
    var bmiAdvice: String?
    
    mutating func calculateBmi(weight: Float, height: Float) {
        let bmi = weight / pow(height, 2)
        if bmi < 18.5 {
            bmiAdvice = "You are in the underweight range. \n Eat some more snacks."
        } else if bmi >= 18.5 && bmi < 24.9 {
            bmiAdvice = "You are in the healthy weight range. \n Great job!"
        } else {
            bmiAdvice = "You are in the overweight range. \n Go on a DIET!!"
        }
        bmiValue = bmi
    }
    
    func getBmiValue() -> String {
        
        // Working with optionals
        /*
         *  1. Force unwrapping - optional!
         *  2. Check for nil value
         *  3. Optional binding - if let safeOptional = optional { // use safeOptional }
         *  4. Nil coelesing operator - optional ?? defaultValue // set default value if nil
         *  5. Optional chaining - optional?.property, optional?.method()
         */
        return String(format: "%0.2f", self.bmiValue ?? "0.0")
    }
    
    func getAdviceLabel() -> String {
        return self.bmiAdvice ?? ""
    }
}
