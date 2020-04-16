//
//  ViewController.swift
//  Quizzler-iOS13
//
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var trueButton: UIButton!
    @IBOutlet weak var falseButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var quizModel = QuizModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        updateUI()
    }

    @IBAction func answerButtonPressed(_ sender: UIButton) {
        
        let selectedAnswer = sender.currentTitle!
        let isAnswerCorrect = quizModel.checkAnswer(selectedAnswer)
        
        if isAnswerCorrect {
            sender.backgroundColor = UIColor.green
        } else {
            sender.backgroundColor = UIColor.red
        }
        quizModel.nextQuestion()
        
        Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
    }
    
    @objc func updateUI() {
        questionLabel.text = quizModel.getQuestionText()
        trueButton.backgroundColor = UIColor.clear
        falseButton.backgroundColor = UIColor.clear
        progressBar.progress = quizModel.getProgress()
        scoreLabel.text = "Score: \(quizModel.getScore())"
    }
    
}

