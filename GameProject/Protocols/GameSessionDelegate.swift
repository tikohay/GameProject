//
//  GameSessionDelegate.swift
//  GameProject
//
//  Created by Karahanyan Levon on 10.06.2021.
//

import Foundation

protocol GameSessionDelegate: AnyObject {
    func showQuestion(question: Question)
}
