//
//  GameSession.swift
//  GameProject
//
//  Created by Karahanyan Levon on 10.06.2021.
//

import Foundation

class GameSession: Codable {
    
    var questions: [Question?] = []
    var totalQuestionsCount = 0
    var correctQuestionsCount = Observable<Int>(0)
    var totalPrize = 0
    var currentQuestion: Question?
    var correctQuestionPercent = 0
    
    private var createSequenceStrategy: CreateSequenceStrategy?
    
    weak var gameDelegate: GameSessionDelegate?
    
    init(correctQuestionsCount: Int, totalPrize: Int, createSequenceStrategy: CreateSequenceStrategy) {
        self.questions = createSequenceStrategy.createSequense()
        self.correctQuestionsCount.value = correctQuestionsCount
        self.totalPrize = totalPrize
        self.totalQuestionsCount = questions.count
        self.createSequenceStrategy = createSequenceStrategy
    }
    
    init(correctQuestionsCount: Int) {
        self.correctQuestionsCount.value = correctQuestionsCount
        self.totalPrize = correctQuestionsCount * 100
    }
    
    func startGame() {
        guard let question = questions[0] else { return }
        
        currentQuestion = question
        gameDelegate?.showQuestion(question: question)
    }
    
    func increaseCorrectQuestionsCount() {
        correctQuestionsCount.value += 1
    }
    
    func checkIfAnswerIsCorrect(answer: String) -> Bool {
        if answer == currentQuestion?.correctAnswer {
            return true
        }
        return false    
    }
    
    func checkIfUserWouldContinueGame(userAnswer: Bool, currentQuestionNum: Int) {
        guard currentQuestionNum < questions.count else { return }
        if userAnswer == true {
            guard let question = questions[currentQuestionNum] else { return }
            currentQuestion = question
            gameDelegate?.showQuestion(question: question)
        }
    }
    
    required init(from decoder: Decoder) throws {
        
    }
    
    func encode(to encoder: Encoder) throws {
        
    }
}
