//
//  ViewController.swift
//  Tipsy
//
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPercentButton: UIButton!
    @IBOutlet weak var tenPercentButton: UIButton!
    @IBOutlet weak var twentyPercentButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    @IBOutlet weak var splitter: UIStepper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tenPercentButton.isSelected = true
    }
    
    func getSelectedTipPercent() -> Float {
        if twentyPercentButton.isSelected  {
            return 20
        } else if zeroPercentButton.isSelected {
            return 0
        }
        
        return 10;
    }

    @IBAction func tipChanged(_ sender: UIButton) {
        billTextField.endEditing(true)
        
        zeroPercentButton.isSelected = false
        tenPercentButton.isSelected = false
        twentyPercentButton.isSelected = false
        sender.isSelected = true
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        billTextField.endEditing(true)
        
        let value = sender.value;
        splitNumberLabel.text = String(format: "%0.0f", value)
    }
    
    @IBAction func calculateButtonPressed(_ sender: UIButton) {
        billTextField.endEditing(true)
        
        performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let tip = getSelectedTipPercent()
            let splitNumber = Float(splitter.value)
            var totalBill: Float? = 0
            if billTextField.text != nil && billTextField.text != "" {
                totalBill = Float(billTextField.text!)
            }
            
            let calculatorModel = CalculatorModel(tipPercentage: tip, totalBill: totalBill, splitNumber: splitNumber)
            let calculatedResult = calculatorModel.getCalculatedResult()
            
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.bilLabel = String(calculatedResult)
            destinationVC.billDetails = "Split between \(String(format: "%0.0f", splitNumber)) people with \(tip)% tip"
        }
    }
    
    
}

