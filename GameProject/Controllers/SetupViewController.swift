//
//  SetupViewController.swift
//  GameProject
//
//  Created by Karahanyan Levon on 15.06.2021.
//

import UIKit

class SetupViewController: UIViewController {
    
    var onSequenceChosen: ((Sequence) -> Void)?
    
    private var selectedSequence: Sequence {
        switch segmentedSequenceControl.selectedSegmentIndex {
        case 0:
            return .sequential
        case 1:
            return .random
        default:
            return .sequential
        }
    }
    
    var descriptionSetupLabel: UILabel = {
        let label = UILabel()
        label.text = "последовательность вопросов:"
        return label
    }()
    
    var segmentedSequenceControl: UISegmentedControl = {
        let segControl = UISegmentedControl(items: ["последовательная", "случайная"])
        segControl.selectedSegmentIndex = 0
        segControl.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        return segControl
    }()
    
    var backButton: UIButton = {
        let button = UIButton()
        button.setTitle("Готово", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        view.addSubview(descriptionSetupLabel)
        view.addSubview(segmentedSequenceControl)
        view.addSubview(backButton)
        
        descriptionSetupLabel.translatesAutoresizingMaskIntoConstraints = false
        segmentedSequenceControl.translatesAutoresizingMaskIntoConstraints = false
        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            descriptionSetupLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            descriptionSetupLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            segmentedSequenceControl.leadingAnchor.constraint(equalTo: descriptionSetupLabel.leadingAnchor),
            segmentedSequenceControl.topAnchor.constraint(equalTo: descriptionSetupLabel.bottomAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: segmentedSequenceControl.bottomAnchor, constant: 20),
            backButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backButton.widthAnchor.constraint(equalToConstant: 100),
            backButton.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
    
    @objc func backButtonTapped() {
        onSequenceChosen!(selectedSequence)
        dismiss(animated: true, completion: nil)
    }
}
