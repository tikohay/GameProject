//
//  AddingQuestionViewController.swift
//  GameProject
//
//  Created by Karahanyan Levon on 16.06.2021.
//

import UIKit

class AddingQuestionViewController: UIViewController {
    
    var newQuestion: String = ""
    var answers: [String] = []
    
    var questionTextView: UITextView = {
        let textView = UITextView()
        textView.layer.borderWidth = 0.5
        textView.layer.borderColor = UIColor.black.cgColor
        textView.backgroundColor = #colorLiteral(red: 0.9513524175, green: 0.8962816596, blue: 0.7789357305, alpha: 1)
        textView.font = UIFont.boldSystemFont(ofSize: 20)
        return textView
    }()
    
    var answerTextViews: [UITextView] = {
        var textViews: [UITextView] = []
        for _ in 0...3 {
            let textView = UITextView()
            textView.layer.borderWidth = 0.2
            textView.layer.borderColor = UIColor.black.cgColor
            textView.translatesAutoresizingMaskIntoConstraints = false
            textView.backgroundColor = #colorLiteral(red: 0.9513524175, green: 0.8962816596, blue: 0.7789357305, alpha: 1)
            textView.font = UIFont.systemFont(ofSize: 20)
            textViews.append(textView)
        }
        return textViews
    }()
    
    var addButton: UIButton = {
        let button = UIButton()
        button.setTitle("добавить", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var correctTextView: UITextView = {
        let textView = UITextView()
        textView.layer.borderWidth = 0.2
        textView.layer.borderColor = UIColor.black.cgColor
        textView.backgroundColor = #colorLiteral(red: 0.9513524175, green: 0.8962816596, blue: 0.7789357305, alpha: 1)
        textView.font = UIFont.systemFont(ofSize: 12)
        textView.text = "Напишите здесь правильный ответ"
        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        view.addGestureRecognizer(tapGesture)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        view.addSubview(questionTextView)
        view.addSubview(addButton)
        view.addSubview(correctTextView)
        
        questionTextView.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false
        correctTextView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            questionTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            questionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            questionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            questionTextView.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        for answerTextView in answerTextViews {
            NSLayoutConstraint.activate([
                answerTextView.heightAnchor.constraint(equalToConstant: 60)
            ])
        }
        
        let leftStackView = UIStackView(arrangedSubviews: [answerTextViews[0], answerTextViews[1]])
        leftStackView.axis = .vertical
        leftStackView.spacing = 30
        leftStackView.distribution = .fillEqually
        
        let rightStackView = UIStackView(arrangedSubviews: [answerTextViews[2], answerTextViews[3]])
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
            mainStackView.topAnchor.constraint(equalTo: questionTextView.bottomAnchor, constant: 50),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            correctTextView.topAnchor.constraint(equalTo: addButton.topAnchor),
            correctTextView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            correctTextView.heightAnchor.constraint(equalTo: answerTextViews.first!.heightAnchor),
            correctTextView.widthAnchor.constraint(equalTo: answerTextViews.first!.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 30),
            addButton.heightAnchor.constraint(equalToConstant: 70),
            addButton.widthAnchor.constraint(equalToConstant: 100),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    @objc func addButtonTapped() {
        newQuestion = questionTextView.text
        for answerTextView in answerTextViews {
            answers.append(answerTextView.text)
        }
        Question.items.append(Question(question: newQuestion, answers: answers, correctAnswer: correctTextView.text))
        Game.shared.addQuestion(Question(question: newQuestion, answers: answers, correctAnswer: correctTextView.text))
        
        dismiss(animated: true, completion: nil)
    }
    
    @objc func viewTapped() {
        view.endEditing(true)
    }
}
