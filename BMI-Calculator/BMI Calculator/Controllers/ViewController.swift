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
        
        let bmi = weight / pow(height, 2)
        print(bmi)
    }
}

