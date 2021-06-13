//
//  CustomAlertViewController.swift
//  GameProject
//
//  Created by Karahanyan Levon on 10.06.2021.
//

import UIKit

class CustomAlertViewController: UIViewController {
    
    var onGameEnd: ((Bool) -> Void)?
    
    var subview = UIView()
    var alertLabel = UILabel()
    var alertImage = UIImageView()
    var continueButton = UIButton()
    var leaveGameButton = UIButton()
    
    var leftButtonText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        setupConstraints()
    }
    
    private func setupConstraints() {
        view.addSubview(subview)
        subview.addSubview(alertLabel)
        subview.addSubview(alertImage)
        subview.addSubview(continueButton)
        subview.addSubview(leaveGameButton)
        
        subview.backgroundColor = .white
        
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            subview.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            subview.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            subview.heightAnchor.constraint(equalToConstant: 400),
            subview.widthAnchor.constraint(equalToConstant: 250)
        ])
        
        alertLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            alertLabel.topAnchor.constraint(equalTo: subview.topAnchor),
            alertLabel.leadingAnchor.constraint(equalTo: subview.leadingAnchor),
            alertLabel.trailingAnchor.constraint(equalTo: subview.trailingAnchor),
            alertLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        continueButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            continueButton.trailingAnchor.constraint(equalTo: subview.trailingAnchor),
            continueButton.bottomAnchor.constraint(equalTo: subview.bottomAnchor),
            continueButton.heightAnchor.constraint(equalToConstant: 50),
            continueButton.widthAnchor.constraint(equalToConstant: 125)
        ])

        leaveGameButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            leaveGameButton.bottomAnchor.constraint(equalTo: subview.bottomAnchor),
            leaveGameButton.leadingAnchor.constraint(equalTo: subview.leadingAnchor),
            leaveGameButton.heightAnchor.constraint(equalToConstant: 50),
            leaveGameButton.widthAnchor.constraint(equalToConstant: 125)
        ])

        alertImage.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            alertImage.topAnchor.constraint(equalTo: alertLabel.bottomAnchor),
            alertImage.leadingAnchor.constraint(equalTo: subview.leadingAnchor),
            alertImage.trailingAnchor.constraint(equalTo: subview.trailingAnchor),
            alertImage.bottomAnchor.constraint(equalTo: continueButton.topAnchor)
        ])
        
        alertLabel.textAlignment = .center
        alertLabel.numberOfLines = 0
        alertLabel.backgroundColor = #colorLiteral(red: 0.4610300064, green: 0.6985866427, blue: 1, alpha: 1)
        alertLabel.textColor = .black
        
        alertImage.contentMode = .scaleToFill

        continueButton.setTitle("Продолжить игру", for: .normal)
        leaveGameButton.setTitle(leftButtonText, for: .normal)
        continueButton.setTitleColor(.white, for: .normal)
        leaveGameButton.setTitleColor(.white, for: .normal)
        continueButton.backgroundColor = .blue
        leaveGameButton.backgroundColor = .red
        continueButton.titleLabel?.numberOfLines = 0
        leaveGameButton.titleLabel?.numberOfLines = 0
        continueButton.titleLabel?.textAlignment = .center
        leaveGameButton.titleLabel?.textAlignment = .center
        continueButton.layer.borderWidth = 0.5
        continueButton.layer.borderColor = UIColor.black.cgColor
        leaveGameButton.layer.borderWidth = 0.5
        leaveGameButton.layer.borderColor = UIColor.black.cgColor
        
        continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        leaveGameButton.addTarget(self, action: #selector(leaveGameButtonTapped), for: .touchUpInside)
    }
    
    @objc func continueButtonTapped() {
        onGameEnd?(true)
        dismiss(animated: true, completion: nil)
    }
    
    @objc func leaveGameButtonTapped() {
        onGameEnd?(false)
        dismiss(animated: true, completion: nil)
    }
}
