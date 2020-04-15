//
//  ViewController.swift
//  EggTimer
//
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let eggTimes = ["Soft": 300, "Medium": 420, "Hard": 720]
    var secondsPassed: Float = 0
    var totalTime: Float = 0
    var timer = Timer()
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBAction func eggPressed(_ sender: UIButton) {
        
        timer.invalidate()
        progressBar.progress = 0
        secondsPassed = 0
        let hardness = sender.currentTitle!
        totalTime = Float(eggTimes[hardness]!)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            progressBar.progress = secondsPassed/totalTime
        } else {
            timer.invalidate()
        }
        
    }
}
