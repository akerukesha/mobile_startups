//
//  BookTableViewCell.swift
//  Pods-KitApp
//
//  Created by Akerke Okapova on 4/26/18.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    @IBOutlet weak var bookBackgroundView: UIView!
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var bookDescriptionLabel: UILabel!
    @IBOutlet weak var pagesLabel: UILabel!
    
    @IBAction func cellButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "ShowInfo", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                switch segue.identifier! {
                case "ShowInfo":
                    let destinationVC = segue.destination as! InfoViewController
        
                    let row = (sender as! IndexPath).row
                    if let volumeInfo = self.books[row]["volumeInfo"] as? [String:AnyObject] {
        
                        let title = volumeInfo["title"] as? String
                        let description = volumeInfo["subtitle"] as? String
                        let authorsArray = (volumeInfo["authors"] as? [String])!
                        var authors = authorsArray.count == 0 ? "" : authorsArray[0]
        
                        destinationVC.bookNameLabel?.text = title
                        destinationVC.bookDescriptionLabel?.text = description
        
                        for author in authorsArray{
                            authors += ", "
                            authors += author
                        }
        
                        destinationVC.bookAuthorsLabel?.text = authors
        
                        var imageUrl = ""
        
        
                        if let imageLinks = volumeInfo["imageLinks"] as? [String:AnyObject]{
                            if let thumbnail = imageLinks["thumbnail"] as? String {
                                destinationVC.bookImageView?.sd_setImage(with: URL(string: thumbnail))
                            }
                        }
                    }
                default:
                    break
                }
                }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let firstColor = UIColor(red: 248/255, green: 216/255, blue: 18/255, alpha: 1).cgColor
        let secondColor = UIColor(red: 239/255, green: 207/255, blue: 10/255, alpha: 1).cgColor
        
        let gradientlayer = CAGradientLayer()
        gradientlayer.frame = self.bookBackgroundView.bounds
        gradientlayer.colors = [firstColor, secondColor]
        bookBackgroundView.layer.addSublayer(gradientlayer)
    }
}
