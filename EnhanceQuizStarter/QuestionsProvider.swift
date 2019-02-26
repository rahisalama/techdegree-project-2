//
//  QuestionsProvider.swift
//  EnhanceQuizStarter
//
//  Created by Rahi on 17/02/2019.
//  Copyright © 2019 Treehouse. All rights reserved.
//
import UIKit
import GameKit

 // questions modeled using a class

class QuestionsData {
    
    let question: String
    let choices: [String]
    let answer: Int
    
    init(question: String, choices: [String], answer: Int) {
            self.question = question
            self.choices = choices
            self.answer = answer
        }
 
}

//creating instances 

let question1 = QuestionsData(question: "Only female koalas can whistle", choices: ["True", "False"], answer: 1)
let question2 = QuestionsData(question: "Blue whales are technically whales", choices: ["True", "False"], answer: 0)
let question3 = QuestionsData(question: "Camels are cannibalistic", choices: ["True", "False"], answer: 1)
let question4 = QuestionsData(question: "All ducks are birds", choices: ["True", "False"], answer: 0)
let question5 = QuestionsData(question: "This was the only US President to serve more than two consecutive terms.", choices: ["George Washington","Franklin D. Roosevelt", "Woodrow Wilson", "Andrew Jackson"], answer: 1)
let question6 = QuestionsData(question: "Which of the following countries has the most residents?", choices: ["Nigeria", "Russia", "Iran", "Vietnam"], answer: 0)
let question7 = QuestionsData(question: "In what year was the United Nations founded?", choices: ["1918","1919","1945", "1954"], answer: 2)
let question8 = QuestionsData(question: "The Titanic departed from the United Kingdom, where was it supposed to arrive?", choices: ["Paris","Washington D.C.","New York City","Boston"], answer: 2)
let question9 = QuestionsData(question: "Which nation produces the most oil?", choices: ["Iran","Iraq","Brazil","Canada"], answer: 3)
let question10 = QuestionsData(question: "Which country has most recently won consecutive World Cups in Soccer?", choices: ["Italy","Brazil","Argetina","Spain"], answer: 1)
let question11 = QuestionsData(question: "Which of the following rivers is longest?", choices: ["Yangtze","Mississippi","Congo","Mekong"], answer: 1)
let question12 = QuestionsData(question: "Which city is the oldest?", choices: ["Mexico City","Cape Town","San Juan","Sydney"], answer: 0)
let question13 = QuestionsData(question: "Which country was the first to allow women to vote in national elections?", choices: ["Poland","United States","Sweden","Senegal"], answer: 0)
let question14 = QuestionsData(question: "Which of these countries won the most medals in the 2012 Summer Games?", choices: ["France","Germany","Japan","Great Britian"], answer: 3)


    let questionLists = [question1,question2,question3,question4,question5,question6,question7,question8,question9,question10,question11,question12,question13,question14]


