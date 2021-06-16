//
//  RandomQuestionsCreateStrategy.swift
//  GameProject
//
//  Created by Karahanyan Levon on 15.06.2021.
//

import Foundation

final class RandomQuestionsCreateStrategy: CreateSequenceStrategy {
    func createSequense() -> [Question] {
        return Game.shared.questions.shuffled()
    }
}
