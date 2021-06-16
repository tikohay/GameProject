//
//  Game.swift
//  GameProject
//
//  Created by Karahanyan Levon on 10.06.2021.
//

import Foundation

class Game {
    
    static let shared = Game()
    private let recordsCareTaker = RecordsCaretaker()
    private let questionCaretaker = QuestionCaretaker()
    
    private(set) var records: [GameSession] {
        didSet {
            recordsCareTaker.save(records: records)
        }
    }
    
    private(set) var questions: [Question] {
        didSet {
            questionCaretaker.save(questions: questions)
        }
    }
    
    var currentSession: GameSession?
    
    func addRecord(_ record: GameSession) {
        records.append(record)
    }
    
    func addQuestion(_ question: Question) {
        questions.insert(question, at: 0)
    }
    
    private init() {
        records = recordsCareTaker.retreveRecords()
        self.questions = questionCaretaker.retreveRecords() + Question.items
    }
}
