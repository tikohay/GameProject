//
//  ViewController.swift
//  GameProject
//
//  Created by Karahanyan Levon on 09.06.2021.
//

import UIKit

class GameViewController: UIViewController {
    
    var record: GameSession?
    var currentQuestionNum = 0
    var questions = Question.items
    
    var delegate: GameViewControllerDelegate?
    
    var questionLabel: UILabel = {
        var label = UILabel()
        label.backgroundColor = .white
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        return label
    }()
    
    var answerButtons: [UIButton] = {
        var buttons: [UIButton] = []
        for i in 0...3 {
            let button = UIButton()
            button.backgroundColor = .white
            button.setTitleColor(.black, for: .normal)
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.black.cgColor
            button.layer.cornerRadius = 10
            button.titleLabel?.numberOfLines = 0
            button.titleLabel?.textAlignment = .center
            button.addTarget(self, action: #selector(answerButtonTapped(sender:)), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: 80).isActive = true
            buttons.append(button)
        }
        return buttons
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        startGame()
    }
    
    private func setupView() {
        view.backgroundColor = #colorLiteral(red: 0.006833140738, green: 0.5212125182, blue: 0.9764973521, alpha: 1)
        
        setupLabelConstraints()
        setupButtonsConstraints()
    }
    
    private func setupLabelConstraints() {
        view.addSubview(questionLabel)
        
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            questionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            questionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            questionLabel.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func setupButtonsConstraints() {
        let leftStackView = UIStackView(arrangedSubviews: [answerButtons[0], answerButtons[1]])
        leftStackView.axis = .vertical
        leftStackView.spacing = 30
        leftStackView.distribution = .fillEqually
        
        let rightStackView = UIStackView(arrangedSubviews: [answerButtons[2], answerButtons[3]])
        rightStackView.axis = .vertical
        rightStackView.spacing = 30
        rightStackView.distribution = .fillEqually
        
        let mainStackView = UIStackView(arrangedSubviews: [leftStackView, rightStackView])
        mainStackView.axis = .horizontal
        mainStackView.spacing = 30
        mainStackView.distribution = .fillEqually
        
        view.addSubview(mainStackView)
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func setupTitles(question: Question) {
        questionLabel.text = question.question
        
        answerButtons[0].setTitle(question.answers[0], for: .normal)
        answerButtons[1].setTitle(question.answers[1], for: .normal)
        answerButtons[2].setTitle(question.answers[2], for: .normal)
        answerButtons[3].setTitle(question.answers[3], for: .normal)
    }
    
    private func startGame() {
        let session = GameSession(correctQuestionsCount: 0, totalPrize: 0, questions: questions)
        session.gameDelegate = self
        
        Game.shared.currentSession = session
        
        session.startGame()
    }
    
    @objc func answerButtonTapped(sender: UIButton) {
        guard currentQuestionNum < questions.count, let userAnswer = sender.titleLabel?.text else { return }
        
        if (Game.shared.currentSession?.checkIfAnswerIsCorrect(answer: userAnswer))! && currentQuestionNum < questions.count {
            currentQuestionNum += 1
            sender.backgroundColor = .green
            
            let vc = CustomAlertViewController()
            vc.continueButton.isHidden = false
            vc.leaveGameButton.isHidden = false
            vc.leftButtonText = "Забрать деньги"
            vc.alertImage.image = UIImage(named: String(Int.random(in: 1...4)))
            vc.alertLabel.text = "Поздравляем! Вы выиграли \(currentQuestionNum * 100) рублей. Играем дальше ?"
            vc.onGameEnd = { [weak self] state in
                guard let self = self else { return }
                if state == true {
                    Game.shared.currentSession?.checkIfUserWouldContinueGame(userAnswer: state, currentQuestionNum: self.currentQuestionNum)
                    sender.backgroundColor = .white
                } else {
                    self.record = GameSession(correctQuestionsCount: self.currentQuestionNum)
                    Game.shared.addRecord(self.record!)
                    self.delegate?.showRecord(record: self.record!)
                    self.navigationController?.popViewController(animated: true)
                }
            }
            vc.modalPresentationStyle = .overCurrentContext
            vc.modalTransitionStyle = .crossDissolve
            present(vc, animated: true, completion: nil)
        } else {
            let vc = CustomAlertViewController()
            vc.continueButton.isHidden = true
            vc.leftButtonText = "в главное меню"
            vc.alertImage.image = UIImage(named: "lose")
            vc.alertLabel.text = "К сожалению вы проиграли(("
            vc.onGameEnd = { _ in
                self.navigationController?.popViewController(animated: true)
            }
            vc.modalPresentationStyle = .overCurrentContext
            vc.modalTransitionStyle = .crossDissolve
            present(vc, animated: true, completion: nil)
        }
    }
}

extension GameViewController: GameSessionDelegate {
    func showQuestion(question: Question) {
        self.setupTitles(question: question)
    }
}

