//
//  GameManager.swift
//  EnhanceQuizStarter
//
//  Created by Rahi on 17/02/2019.
//  Copyright © 2019 Treehouse. All rights reserved.
//
import UIKit
import GameKit

class GameManager {
    
    // questions modeled using a class
    
    struct Question {
        
        let question: String
        let choices: [String]
        let answer: Int
        
    }
    
    //creating instances
    
    let question1 = Question(question: "Only female koalas can whistle", choices: ["True", "False"], answer: 1)
    let question2 = Question(question: "Blue whales are technically whales", choices: ["True", "False"], answer: 0)
    let question3 = Question(question: "Camels are cannibalistic", choices: ["True", "False"], answer: 1)
    let question4 = Question(question: "All ducks are birds", choices: ["True", "False"], answer: 0)
    let question5 = Question(question: "This was the only US President to serve more than two consecutive terms.", choices: ["George Washington","Franklin D. Roosevelt", "Woodrow Wilson", "Andrew Jackson"], answer: 1)
    let question6 = Question(question: "Which of the following countries has the most residents?", choices: ["Nigeria", "Russia", "Iran", "Vietnam"], answer: 0)
    let question7 = Question(question: "In what year was the United Nations founded?", choices: ["1918","1919","1945", "1954"], answer: 2)
    let question8 = Question(question: "The Titanic departed from the United Kingdom, where was it supposed to arrive?", choices: ["Paris","Washington D.C.","New York City","Boston"], answer: 2)
    let question9 = Question(question: "Which nation produces the most oil?", choices: ["Iran","Iraq","Brazil","Canada"], answer: 3)
    let question10 = Question(question: "Which country has most recently won consecutive World Cups in Soccer?", choices: ["Italy","Brazil","Argetina","Spain"], answer: 1)
    let question11 = Question(question: "Which of the following rivers is longest?", choices: ["Yangtze","Mississippi","Congo","Mekong"], answer: 1)
    let question12 = Question(question: "Which city is the oldest?", choices: ["Mexico City","Cape Town","San Juan","Sydney"], answer: 0)
    let question13 = Question(question: "Which country was the first to allow women to vote in national elections?", choices: ["Poland","United States","Sweden","Senegal"], answer: 0)
    let question14 = Question(question: "Which of these countries won the most medals in the 2012 Summer Games?", choices: ["France","Germany","Japan","Great Britian"], answer: 3)
    
    
    // MARK: - Properties
    let questionsPerRound = 14
    var questionsAsked = 0
    var correctQuestions = 0
    var questionArray = [Question]()
    var shuffledQuestions = [Question]()
    
    
    init() {
        self.questionArray = [question1,question2,question3,question4,question5,question6,question7,question8,question9,question10,question11,question12,question13,question14]
    }
    
    // shuffling the array
    func shuffleArray() {
        shuffledQuestions = questionArray.shuffled()
    }
    
    // selecting the questions from the shffuled array
    func questionGenerator() -> Question {
        let theQuestion = shuffledQuestions[questionsAsked]
        return theQuestion
    }
    
    // check the answers
    func checkTheAnswer(selectedButton: Int) -> String {
       
        let correctAnswer = shuffledQuestions[questionsAsked].answer
        
        if (selectedButton == 0 &&  correctAnswer == 0) {
            correctQuestions += 1
            questionsAsked += 1
            
            return "Correct!"
            
        } else if (selectedButton == 1 && correctAnswer == 1) {
            correctQuestions += 1
            questionsAsked += 1
        
            return "Correct!"
            
        } else if (selectedButton == 2 && correctAnswer == 2) {
            correctQuestions += 1
            questionsAsked += 1
            
            
            return "Correct!"
            
        } else if (selectedButton == 3 && correctAnswer == 3){
            correctQuestions += 1
            questionsAsked += 1
            
            return "Correct!"
            
        } else {
         questionsAsked += 1
         
         return "Sorry, wrong answer!"
            
        }
    }
    
    // check if the game is over or not
    func gameIsOver() -> Bool {
         if questionsAsked == questionsPerRound {
            
            return true
            
         } else {
            
         return false
            
        }
        
    }
    
    // rest values
    func restValue() {
        self.questionsAsked = 0
        self.correctQuestions = 0
        shuffleArray()
    }
    
}
