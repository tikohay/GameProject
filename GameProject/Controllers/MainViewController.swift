//
//  MainViewController.swift
//  GameProject
//
//  Created by Karahanyan Levon on 10.06.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    var sequence: Sequence = .sequential
    
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
    
    var toSetupButton: UIButton = {
        let button = UIButton()
        button.setTitle("Настройки", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0, green: 0.5975896716, blue: 1, alpha: 1)
        button.addTarget(self, action: #selector(toSetupButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var addQuestionButton: UIButton = {
        let button = UIButton()
        button.setTitle("Добавить вопрос", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0, green: 0.5975896716, blue: 1, alpha: 1)
        button.addTarget(self, action: #selector(addQuestionButtonTapped), for: .touchUpInside)
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
            recordLabel.text = "Последний рекорд\nрублей: \(String(describing: Game.shared.records.last?.totalPrize))\nправильных ответов: \(String(describing: Game.shared.records.last?.correctQuestionsCount.value))"
        } else {
            recordLabel.text = ""
        }
    }
    
    private func setupConstraints() {
        view.addSubview(recordLabel)
        view.addSubview(startButton)
        view.addSubview(resultsButton)
        view.addSubview(toSetupButton)
        view.addSubview(addQuestionButton)
        
        recordLabel.translatesAutoresizingMaskIntoConstraints = false
        startButton.translatesAutoresizingMaskIntoConstraints = false
        resultsButton.translatesAutoresizingMaskIntoConstraints = false
        toSetupButton.translatesAutoresizingMaskIntoConstraints = false
        addQuestionButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            recordLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            recordLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            recordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            recordLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
        
        NSLayoutConstraint.activate([
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.bottomAnchor.constraint(equalTo: resultsButton.topAnchor, constant: -10),
            startButton.heightAnchor.constraint(equalToConstant: 70),
            startButton.widthAnchor.constraint(equalToConstant: 150)
        ])
        
        NSLayoutConstraint.activate([
            resultsButton.bottomAnchor.constraint(equalTo: toSetupButton.topAnchor, constant: -10),
            resultsButton.centerXAnchor.constraint(equalTo: startButton.centerXAnchor),
            resultsButton.heightAnchor.constraint(equalToConstant: 70),
            resultsButton.widthAnchor.constraint(equalToConstant: 150)
        ])
        
        NSLayoutConstraint.activate([
            toSetupButton.bottomAnchor.constraint(equalTo: addQuestionButton.topAnchor, constant: -10),
            toSetupButton.centerXAnchor.constraint(equalTo: startButton.centerXAnchor),
            toSetupButton.heightAnchor.constraint(equalToConstant: 70),
            toSetupButton.widthAnchor.constraint(equalToConstant: 150)
        ])
        
        NSLayoutConstraint.activate([
            addQuestionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            addQuestionButton.centerXAnchor.constraint(equalTo: startButton.centerXAnchor),
            addQuestionButton.heightAnchor.constraint(equalToConstant: 70),
            addQuestionButton.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    @objc func startButtonTapped() {
        let vc = GameViewController()
        vc.delegate = self
        vc.sequence = sequence
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func resultsButtonTapped() {
        navigationController?.pushViewController(ResultatsTableViewController(), animated: true)
    }
    
    @objc func toSetupButtonTapped() {
        let toVC = SetupViewController()
        toVC.onSequenceChosen = { sequence in
            self.sequence = sequence
        }
        toVC.modalPresentationStyle = .overCurrentContext
        toVC.modalTransitionStyle = .crossDissolve
        present(toVC, animated: true, completion: nil)
    }
    
    @objc func addQuestionButtonTapped() {
        let toVC = AddingQuestionViewController()
        toVC.modalPresentationStyle = .overCurrentContext
        toVC.modalTransitionStyle = .crossDissolve
        present(toVC, animated: true, completion: nil)
    }
}

extension MainViewController: GameViewControllerDelegate {
    func showRecord(record: GameSession) {
        recordLabel.text = "Последний рекорд\nрублей: \(record.totalPrize)\nправильных ответов: \(record.correctQuestionsCount)"
    }
}
