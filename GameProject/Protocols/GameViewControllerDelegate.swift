//
//  GameViewControllerDelegate.swift
//  GameProject
//
//  Created by Karahanyan Levon on 11.06.2021.
//

import Foundation

protocol GameViewControllerDelegate: AnyObject {
    func showRecord(record: GameSession)
}
