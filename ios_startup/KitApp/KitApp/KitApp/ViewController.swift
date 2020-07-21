//
//  ViewController.swift
//  KitApp
//
//  Created by Akerke Okapova on 4/26/18.
//  Copyright © 2018 Akerke Okapova. All rights reserved.
//

import UIKit
import SwiftyJSON
import SDWebImage

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var bookTableView: UITableView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var nothingFoundImageView: UIImageView!
    
    var books: [[String:AnyObject]] = []
    
    @IBAction func onSearchButtonPressed(_ sender: UIButton) {
        if searchTextField.text?.count != 0 {
            //            self.bookTableView.alpha = 1
            performAnimation()
            getBooks(bookTitle: searchTextField.text!)
        }
    }
    func getBooks(bookTitle: String){
        let stringUrl = "https://www.googleapis.com/books/v1/volumes?q=\(bookTitle.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)"
        
        guard let url = NSURL(string: stringUrl) else {
            return
        }
        let urlRequest = URLRequest(url: url as URL)
        let session = URLSession.shared
        
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            if ((error) != nil) {
                print(error?.localizedDescription)
            }else{
                let json = JSON(data)
                if let items = json["items"].arrayObject{
                    self.books = items as! [[String:AnyObject]]
//                    print(self.books)
                    DispatchQueue.main.async {
                        self.nothingFoundImageView.alpha = 0
                    }
                }else{
                    DispatchQueue.main.async {
                        self.bookTableView.alpha = 0
                        self.nothingFoundImageView.alpha = 1
                    }
                }
                
                DispatchQueue.main.async {
                    self.bookTableView.reloadData()
                }
            }
        }
        task.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboard()
        
        searchTextField.layer.cornerRadius = 8
        searchButton.layer.cornerRadius = 8
        searchTextField.layer.sublayerTransform = CATransform3DMakeTranslation(16, 0, 0)
        
        searchTextField.delegate = self
        
        bookTableView.delegate = self
        bookTableView.dataSource = self
        
        bookTableView.tableFooterView = UIView()
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        textField.layer.shadowOpacity = 0.2
        textField.layer.shadowOffset = CGSize(width: 0, height: 1)
        textField.layer.shadowRadius = 5
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.shadowOpacity = 0
    }
    
    func performAnimation(){
        self.view.endEditing(true)
        UIView.animate(withDuration: 0.75) {
            self.logoImageView.alpha = 0
            self.searchButton.alpha = 0
            self.searchTextField.frame.origin.y = 24
            self.bookTableView.alpha = 1
        }
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text?.count != 0 {
//            self.bookTableView.alpha = 1
            performAnimation()
            getBooks(bookTitle: textField.text!)
        }
        return true
    }
}

extension UIViewController{
    
    func hideKeyboard(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as! BookTableViewCell
        
        if let volumeInfo = self.books[indexPath.row]["volumeInfo"] as? [String:AnyObject] {
            
            let title = volumeInfo["title"] as? String
            let description = volumeInfo["subtitle"] as? String
            let authorsArray = (volumeInfo["authors"] as? [String])!
            var authors = authorsArray.count == 0 ? "" : authorsArray[0]
            
            for author in authorsArray{
                authors += ", "
                authors += author
            }
            
            var imageUrl = ""
            
            print(authors)
            
            cell.bookTitleLabel?.text = volumeInfo["title"] as? String
            cell.bookDescriptionLabel?.text = volumeInfo["subtitle"] as? String
            
            cell.pagesLabel?.text = "Pages: \((volumeInfo["pageCount"] != nil ? volumeInfo["pageCount"]! as! Int : 0))"
            
            if let imageLinks = volumeInfo["imageLinks"] as? [String:AnyObject]{
                if let thumbnail = imageLinks["thumbnail"] as? String {
                    imageUrl = thumbnail
                    cell.bookImageView.sd_setImage(with: URL(string: thumbnail))
                }
            }
        }
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "ShowInfo", sender: indexPath)
//    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        switch segue.identifier! {
//        case "ShowInfo":
//            let destinationVC = segue.destination as! InfoViewController
//
//            let row = (sender as! IndexPath).row
//            if let volumeInfo = self.books[row]["volumeInfo"] as? [String:AnyObject] {
//
//                let title = volumeInfo["title"] as? String
//                let description = volumeInfo["subtitle"] as? String
//                let authorsArray = (volumeInfo["authors"] as? [String])!
//                var authors = authorsArray.count == 0 ? "" : authorsArray[0]
//
//                destinationVC.bookNameLabel?.text = title
//                destinationVC.bookDescriptionLabel?.text = description
//
//                for author in authorsArray{
//                    authors += ", "
//                    authors += author
//                }
//
//                destinationVC.bookAuthorsLabel?.text = authors
//
//                var imageUrl = ""
//
//
//                if let imageLinks = volumeInfo["imageLinks"] as? [String:AnyObject]{
//                    if let thumbnail = imageLinks["thumbnail"] as? String {
//                        destinationVC.bookImageView?.sd_setImage(with: URL(string: thumbnail))
//                    }
//                }
//            }
//        default:
//            break
//        }
//        }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 152
    }
}
