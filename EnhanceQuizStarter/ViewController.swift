//
//  ViewController.swift
//  EnhanceQuizStarter
//
//  Created by Pasan Premaratne on 3/12/18.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import UIKit
import GameKit
import AudioToolbox

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    let questionsPerRound = questionLists.count
    var questionsAsked = 0
    var correctQuestions = 0
    var indexOfSelectedQuestion = 0
    var gameSound: SystemSoundID = 0
    var usedIndex: [Int] = []

    
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
        
        loadGameStartSound()
        playGameStartSound()
        displayQuestion()
    }
    
    // MARK: - Helpers
    
    func loadGameStartSound() {
        let path = Bundle.main.path(forResource: "GameSound", ofType: "wav")
        let soundUrl = URL(fileURLWithPath: path!)
        AudioServicesCreateSystemSoundID(soundUrl as CFURL, &gameSound)
    }
    
    func playGameStartSound() {
        AudioServicesPlaySystemSound(gameSound)
    }
    
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
    
 
    func displayQuestion() {
        
        // random number generator
        indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextInt(upperBound: questionLists.count)
        let questionDictionary = questionLists[indexOfSelectedQuestion]
        
        // the Question of the round
        questionField.text = questionDictionary.question

       
        
        // display 2 o 4 choices depnds the questions
        
        if questionDictionary.choices.count == 2  {
        option3Button.isHidden = true
        option4Button.isHidden = true
        playAgainButton.isHidden = true
        checkingAnswerLable.isHidden = true
        nextQuestionButton.isHidden = true
        option1Button.setTitle(questionDictionary.choices[0], for: .normal)
        option2Button.setTitle(questionDictionary.choices[1], for: .normal)
            option1Button.alpha = 1.0
            option2Button.alpha = 1.0
        
            // Enable the BUTTON
            option1Button.isEnabled = true
            option2Button.isEnabled = true
            
        } else {
        playAgainButton.isHidden = true
        option3Button.isHidden = false
        option4Button.isHidden = false
        checkingAnswerLable.isHidden = true
        nextQuestionButton.isHidden = true
        option1Button.setTitle(questionDictionary.choices[0], for: .normal)
        option2Button.setTitle(questionDictionary.choices[1], for: .normal)
        option3Button.setTitle(questionDictionary.choices[2], for: .normal)
        option4Button.setTitle(questionDictionary.choices[3], for: .normal)
        
        option1Button.alpha = 1.0
        option2Button.alpha = 1.0
        option3Button.alpha = 1.0
        option4Button.alpha = 1.0
        
        // Enable the BUTTONS
            option1Button.isEnabled = true
            option2Button.isEnabled = true
            option3Button.isEnabled = true
            option4Button.isEnabled = true
            
            
        }
       
        
    }
    
    func displayScore() {
        
        hideOptionsButtons(status: true)
        checkingAnswerLable.isHidden = true
        
        // Display play again button
        playAgainButton.isHidden = false
        
        // display the final result
        if correctQuestions == questionsPerRound {
            questionField.text = "Congrats!\nYou got \(correctQuestions) out of \(questionsPerRound) correct!"
        } else {
        questionField.text = "Way to go!\nYou got \(correctQuestions) out of \(questionsPerRound) correct!"
        }
    }
    
    func nextRound() {
        
            if questionsAsked == questionsPerRound {
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
        questionsAsked += 1
        
        let selectedQuestionDict = questionLists[indexOfSelectedQuestion]
        let correctAnswer = selectedQuestionDict.answer
        
        
        if (sender === option1Button &&  correctAnswer == 0) || (sender === option2Button && correctAnswer == 1) || (sender === option3Button && correctAnswer == 2) || (sender === option4Button && correctAnswer == 3) {
            correctQuestions += 1
            
            // display the Answer result if correct
            checkingAnswerLable.isHidden = false
            checkingAnswerLable.text = "Correct!"
            checkingAnswerLable.textColor = #colorLiteral(red: 0, green: 0.5764705882, blue: 0.5294117647, alpha: 1)
            
            //
            option1Button.alpha = 0.50
            option2Button.alpha = 0.50
            option3Button.alpha = 0.50
            option4Button.alpha = 0.50
            
            // disable the BUTTONS
            option1Button.isEnabled = false
            option2Button.isEnabled = false
            option3Button.isEnabled = false
            option4Button.isEnabled = false
            
        } else {
            
            // display the Answer result if NOT correct
            checkingAnswerLable.isHidden = false
            checkingAnswerLable.text = "Sorry, wrong answer!"
            checkingAnswerLable.textColor = #colorLiteral(red: 1, green: 0.6366160512, blue: 0.3839452267, alpha: 1)
            option1Button.alpha = 0.50
            option2Button.alpha = 0.50
            option3Button.alpha = 0.50
            option4Button.alpha = 0.50
            
            // disable Options BUTTONS
            option1Button.isEnabled = false
            option2Button.isEnabled = false
            option3Button.isEnabled = false
            option4Button.isEnabled = false
    
        }
        
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
        usedIndex = []
        questionsAsked = 0
        correctQuestions = 0
        nextRound()
    }
    
  
}


