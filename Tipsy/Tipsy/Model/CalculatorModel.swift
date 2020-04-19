//
//  CalculatorModel.swift
//  Tipsy
//
//  Created by Richa Deshmukh on 4/19/20.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import Foundation

struct CalculatorModel {
    
    var tipPercentage: Float!
    var totalBill: Float!
    var splitNumber: Float!
    
    func getTotalBill() -> Float {
        return totalBill ?? 0
    }
    
    func getTipPercentage() -> Float {
        return tipPercentage ?? 0
    }
    
    func getSplitNumber() -> Float {
        return splitNumber ?? 0
    }
    
    func getCalculatedResult() -> Float {
        let bill = totalBill + (tipPercentage/100) * totalBill
        return bill/splitNumber
    }
}
