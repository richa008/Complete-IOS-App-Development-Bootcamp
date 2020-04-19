//
//  ViewController.swift
//  BMI Calculator
//
//  Created by Angela Yu on 21/08/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

class BmiViewController: UIViewController {

    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var heightSlider: UISlider!
    @IBOutlet weak var weightSlider: UISlider!
    
    var bmiModel = BmiModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func weightSliderChanged(_ sender: UISlider) {
        let value = String(format: "%0.0f", sender.value)
        weightLabel.text = "\(value)Kg"
    }
    
    @IBAction func heightSliderChanged(_ sender: UISlider) {
        let value = String(format: "%0.2f", sender.value)
        heightLabel.text = "\(value)m"
    }
    
    @IBAction func calculateBmiButtonPressed(_ sender: Any) {
        let height = heightSlider.value
        let weight = weightSlider.value
        bmiModel.calculateBmi(weight: weight, height: height)
        self.performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.bmi = bmiModel.getBmiValue()
            destinationVC.bmiAdvice = bmiModel.getAdviceLabel()
            
        }
    }
}

