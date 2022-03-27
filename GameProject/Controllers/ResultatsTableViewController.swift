//
//  ResultatsTableViewController.swift
//  GameProject
//
//  Created by Karahanyan Levon on 11.06.2021.
//

import UIKit

class ResultatsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return Game.shared.records.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let records = Game.shared.records[indexPath.row]
        
        cell.backgroundColor = #colorLiteral(red: 0, green: 0.6697863936, blue: 1, alpha: 1)
        cell.textLabel?.textColor = .white
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = "Выиграно денег: \(records.totalPrize)\nКоличество правильных ответов: \(records.correctQuestionsCount)"

        return cell
    }
}
