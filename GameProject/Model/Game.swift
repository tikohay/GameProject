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
    
    private(set) var records: [GameSession] {
        didSet {
            recordsCareTaker.save(records: records)
        }
    }
    
    var currentSession: GameSession?
    
    func addRecord(_ record: GameSession) {
        records.append(record)
    }
    
    private init() {
        records = recordsCareTaker.retreveRecords()
    }
}
