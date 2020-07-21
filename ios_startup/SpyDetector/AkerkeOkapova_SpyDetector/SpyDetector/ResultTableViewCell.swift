//
//  ResultTableViewCell.swift
//  SpyDetector
//
//  Created by Akerke Okapova on 4/26/18.
//  Copyright © 2018 Akerke Okapova. All rights reserved.
//

import UIKit

class ResultTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    @IBOutlet weak var wrongLabel: UILabel!
    
    var game: Game!{
        
        didSet{
            updateUI()
        }
    }
    
    func updateUI(){
        nameLabel?.text = game.name
        rightLabel?.text = "\(game.rightAnswerCnt)"
        wrongLabel?.text = "\(game.wrongAnswerCnt)"
    }
}
