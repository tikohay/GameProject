//
//  RecodsCaretaker.swift
//  GameProject
//
//  Created by Karahanyan Levon on 11.06.2021.
//

import Foundation


final class RecordsCaretaker {
    
    typealias Memento = Data
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    private let key = "records"
    
    func save(records: [GameSession]) {
        do {
            let data: Memento = try self.encoder.encode(records)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print(error)
        }
    }
    
    func retreveRecords() -> [GameSession] {
        guard let data = UserDefaults.standard.data(forKey: key) else { return [] }
        
        do {
            return try self.decoder.decode([GameSession].self, from: data)
        } catch {
            print(error)
            return []
        }
    }
}
