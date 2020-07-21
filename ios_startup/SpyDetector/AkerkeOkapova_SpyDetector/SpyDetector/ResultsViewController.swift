//
//  ResultsViewController.swift
//  SpyDetector
//
//  Created by Akerke Okapova on 4/26/18.
//  Copyright © 2018 Akerke Okapova. All rights reserved.
//

import UIKit

extension Constants {
    
    static let resultCell = "resultCell"
    
    static let mainStoryboard = "Main"
    static let startVC = "StartViewController"
}

class ResultsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var rightLabel: UILabel!
    @IBOutlet weak var wrongLabel: UILabel!
    
    @IBAction func exitButtonPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: Constants.mainStoryboard, bundle: nil)
        let newVC = storyboard.instantiateViewController(withIdentifier: Constants.startVC) as! StartViewController
        self.show(newVC, sender: nil)
        
    }
    
    var game: Game!{
        didSet{
            updateUI()
        }
    }
    
    func updateUI(){
        rightLabel?.text = "Right answers: \(game.rightAnswerCnt)"
        wrongLabel?.text = "Wrong answers: \(game.wrongAnswerCnt)"
    }
    
    func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        updateUI()
    }
}

extension ResultsViewController: UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameManager.leaderboard.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.resultCell, for: indexPath) as! ResultTableViewCell
        cell.game = gameManager.leaderboard[indexPath.row]
        return cell
    }
}
