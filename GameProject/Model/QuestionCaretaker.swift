//
//  QuestionCaretaker.swift
//  GameProject
//
//  Created by Karahanyan Levon on 16.06.2021.
//

import Foundation

final class QuestionCaretaker {
    
    typealias Memento = Data
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    private let key = "questions"
    
    func save(questions: [Question]) {
        do {
            let data: Memento = try self.encoder.encode(questions)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print(error)
        }
    }
    
    func retreveRecords() -> [Question] {
        guard let data = UserDefaults.standard.data(forKey: key) else { return [] }
        
        do {
            return try self.decoder.decode([Question].self, from: data)
        } catch {
            print(error)
            return []
        }
    }
}
