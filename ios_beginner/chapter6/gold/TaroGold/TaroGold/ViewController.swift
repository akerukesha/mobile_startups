//
//  ViewController.swift
//  TaroGold
//
//  Created by Akerke Okapova on 2/20/18.
//  Copyright © 2018 Akerke Okapova. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var categoriesTableView: UITableView!
    
    var game = Game()
    
    @IBAction func startButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: Constants.gameSegue, sender: game)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier!{
        case Constants.gameSegue:
            let destinationVC = segue.destination as! GameViewController
            destinationVC.game = sender as! Game
        default:
            break
        }
    }
    
    private func configureTableView() {
        categoriesTableView.estimatedRowHeight = 200
        categoriesTableView.rowHeight = UITableViewAutomaticDimension
        categoriesTableView.tableFooterView = UIView()
        
        let indexPath = IndexPath(row: 0, section: 0)
        categoriesTableView.selectRow(at: indexPath, animated: true, scrollPosition: .bottom)
        categoriesTableView.delegate?.tableView!(categoriesTableView, didSelectRowAt: indexPath)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = categoriesTableView.dequeueReusableCell(withIdentifier: Constants.categoryCellIdentifier, for: indexPath) as! CategoryTableViewCell
        cell.title = Constants.categoryNames[Constants.categories[indexPath.row]]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        game.setCategory(index: indexPath.row)
        print("current category: \(game.currentCategory)")
    }
}
