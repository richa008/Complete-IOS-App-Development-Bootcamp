//
//  ResultsViewController.swift
//  Tipsy
//
//  Created by Richa Deshmukh on 4/19/20.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {

    @IBOutlet weak var billPerPersonLabel: UILabel!
    @IBOutlet weak var billDescriptionLabel: UILabel!
    
    var bilLabel: String?
    var billDetails: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        billPerPersonLabel.text = bilLabel
        billDescriptionLabel.text = billDetails
    }
    
    @IBAction func recalculateButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

}
