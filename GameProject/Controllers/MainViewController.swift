//
//  MainViewController.swift
//  GameProject
//
//  Created by Karahanyan Levon on 10.06.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    var recordLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    
    var startButton: UIButton = {
       let button = UIButton()
        button.setTitle("Начать игру", for: .normal)
        button.backgroundColor = .green
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var resultsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Результаты", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0, green: 0.5975896716, blue: 1, alpha: 1)
        button.addTarget(self, action: #selector(resultsButtonTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .blue
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .blue
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        title = "Главное меню"
        
        setupRecordLabel()
        setupConstraints()
    }
    
    func setupRecordLabel() {
        if Game.shared.records.last != nil {
            recordLabel.text = "Последний рекорд\nрублей: \(String(describing: Game.shared.records.last?.totalPrize))\nправильных ответов: \(String(describing: Game.shared.records.last?.correctQuestionsCount))"
        } else {
            recordLabel.text = ""
        }
    }
    
    private func setupConstraints() {
        view.addSubview(recordLabel)
        view.addSubview(startButton)
        view.addSubview(resultsButton)
        
        recordLabel.translatesAutoresizingMaskIntoConstraints = false
        startButton.translatesAutoresizingMaskIntoConstraints = false
        resultsButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            recordLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            recordLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            recordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            recordLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
        
        NSLayoutConstraint.activate([
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.bottomAnchor.constraint(equalTo: resultsButton.topAnchor, constant: -50),
            startButton.heightAnchor.constraint(equalToConstant: 100),
            startButton.widthAnchor.constraint(equalToConstant: 150)
        ])
        
        NSLayoutConstraint.activate([
            resultsButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            resultsButton.centerXAnchor.constraint(equalTo: startButton.centerXAnchor),
            resultsButton.heightAnchor.constraint(equalToConstant: 100),
            resultsButton.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    @objc func startButtonTapped() {
        let vc = GameViewController()
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func resultsButtonTapped() {
        navigationController?.pushViewController(ResultatsTableViewController(), animated: true)
    }
}

extension MainViewController: GameViewControllerDelegate {
    func showRecord(record: GameSession) {
        recordLabel.text = "Последний рекорд\nрублей: \(record.totalPrize)\nправильных ответов: \(record.correctQuestionsCount)"
    }
}
