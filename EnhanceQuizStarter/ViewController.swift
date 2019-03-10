//
//  ViewController.swift
//  EnhanceQuizStarter
//
//  Created by Pasan Premaratne on 3/12/18.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import UIKit



class ViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var option1Button: UIButton!
    @IBOutlet weak var option2Button: UIButton!
    @IBOutlet weak var option3Button: UIButton!
    @IBOutlet weak var option4Button: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var checkingAnswerLable: UILabel!
    @IBOutlet weak var nextQuestionButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        option1Button.layer.cornerRadius = 5
        option2Button.layer.cornerRadius = 5
        option3Button.layer.cornerRadius = 5
        option4Button.layer.cornerRadius = 5
        playAgainButton.layer.cornerRadius = 5
        nextQuestionButton.layer.cornerRadius = 5
    
        gameManager.shuffleArray()
        PlaySounds.loadGameStartSound()
        PlaySounds.playGameStartSound()
        nextRound()
    }
    
    
    let gameManager = GameManager.init()
    
    // MARK: - Helpers
    // Hiding and showing Options Buttons
    func hideOptionsButtons(status: Bool) {
        
        if status == true {
            option1Button.isHidden = true
            option2Button.isHidden = true
            option3Button.isHidden = true
            option4Button.isHidden = true
        } else if status == false {
            option1Button.isHidden = false
            option2Button.isHidden = false
            option3Button.isHidden = false
            option4Button.isHidden = false
        }
    }
    
    func enableButtons(status: Bool) {
        
        if status == true {
            option1Button.isEnabled = true
            option2Button.isEnabled = true
            option3Button.isEnabled = true
            option4Button.isEnabled = true
        } else if status == false {
            option1Button.isEnabled = false
            option2Button.isEnabled = false
            option3Button.isEnabled = false
            option4Button.isEnabled = false
        }
    }
    
    func buttonsAlpha(degree: CGFloat) {
        
        option1Button.alpha = degree
        option2Button.alpha = degree
        option3Button.alpha = degree
        option4Button.alpha = degree
        
    }
    
 
    func displayQuestion() {
        
        // selecting a question form the suffled Array
        let extractTheQuestion = gameManager.questionGenerator()
        // the Question of the round
        questionField.text = extractTheQuestion.question
        
        // display 2 o 4 choices depnds the questions
        
        if extractTheQuestion.choices.count == 2  {
        option3Button.isHidden = true
        option4Button.isHidden = true
        playAgainButton.isHidden = true
        checkingAnswerLable.isHidden = true
        nextQuestionButton.isHidden = true
        option1Button.setTitle(extractTheQuestion.choices[0], for: .normal)
        option2Button.setTitle(extractTheQuestion.choices[1], for: .normal)
            
            buttonsAlpha(degree: 1.0)
            // Enable the BUTTON
            enableButtons(status: true)
            
        } else {
        playAgainButton.isHidden = true
        option3Button.isHidden = false
        option4Button.isHidden = false
        checkingAnswerLable.isHidden = true
        nextQuestionButton.isHidden = true
        option1Button.setTitle(extractTheQuestion.choices[0], for: .normal)
        option2Button.setTitle(extractTheQuestion.choices[1], for: .normal)
        option3Button.setTitle(extractTheQuestion.choices[2], for: .normal)
        option4Button.setTitle(extractTheQuestion.choices[3], for: .normal)
        
        buttonsAlpha(degree: 1.0)
        
        // Enable the BUTTONS
          enableButtons(status: true)
            
            
        }
       
        
    }
    
    func displayScore() {
        
        // hiding all BUTTONS + Checking Answer Lable
        hideOptionsButtons(status: true)
        checkingAnswerLable.isHidden = true
        
        // Display PLAY AGAIN button
        playAgainButton.isHidden = false
        
        // display the final result
        if gameManager.correctQuestions == gameManager.questionsPerRound {
            questionField.text = "Congrats!\nYou got \(gameManager.correctQuestions) out of \(gameManager.questionsPerRound) correct!"
        } else {
            questionField.text = "Way to go!\nYou got \(gameManager.correctQuestions) out of \(gameManager.questionsPerRound) correct!"
        }
    }
    
    func nextRound() {
            let gameOver = gameManager.gameIsOver()
            if gameOver == true {
                // Game is over
                displayScore()
                // dissapear the next question's BUTTON
                nextQuestionButton.isHidden = true
                
            } else {
                
            // go to the next Question
                displayQuestion()
            }
        }
     
    
    
    func loadNextRound(delay seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
        
        // Executes the nextRound method at the dispatch time on the main queue
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            self.nextRound()
        }
    }
    
    // MARK: - Actions
    
    @IBAction func checkAnswer(_ sender: UIButton) {
        // Increment the questions asked counter
        let correctAnswer = gameManager.shuffledQuestions[gameManager.questionsAsked].answer
        
        switch sender {
        case option1Button: checkingAnswerLable.text = gameManager.checkTheAnswer(selectedButton: 0)
        case option2Button: checkingAnswerLable.text = gameManager.checkTheAnswer(selectedButton: 1)
        case option3Button: checkingAnswerLable.text = gameManager.checkTheAnswer(selectedButton: 2)
        case option4Button: checkingAnswerLable.text = gameManager.checkTheAnswer(selectedButton: 3)
        default: break
        }
        
    
        // text color for checking answer field
        if (sender === option1Button && correctAnswer == 0) || (sender === option2Button && correctAnswer == 1) || (sender === option3Button && correctAnswer == 2) || (sender === option4Button && correctAnswer == 3) {
            checkingAnswerLable.textColor = #colorLiteral(red: 0, green: 0.5764705882, blue: 0.5294117647, alpha: 1)
            
        } else {
            checkingAnswerLable.textColor = #colorLiteral(red: 1, green: 0.6366160512, blue: 0.3839452267, alpha: 1)
        }
        
        
        enableButtons(status: false)
        buttonsAlpha(degree: 0.50)
        checkingAnswerLable.isHidden = false
        // display the Next Question's BUTTON for the nextRound
        nextQuestionButton.isHidden = false
        
  
    }
    
    // Action of the Next Question's BUTTON
    @IBAction func goToNextQuestion(_ sender: UIButton) {
        loadNextRound(delay: 0)
    }
    
    // Action of the play again's BUTTON
    @IBAction func playAgain(_ sender: UIButton) {
        
        // Show the Options buttons
        hideOptionsButtons(status: false)
        
        // Rest Value
        gameManager.restValue()
        nextRound()
    }
    
  
}


