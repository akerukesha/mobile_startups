//
//  CategoryTableViewCell.swift
//  TaroGold
//
//  Created by Akerke Okapova on 2/20/18.
//  Copyright © 2018 Akerke Okapova. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    
    @IBOutlet weak var categoryTitleLabel: UILabel!
    
    var title: String! {
        didSet{
            updateUI()
        }
    }
    
    private func updateUI(){
        categoryTitleLabel.text = title
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
