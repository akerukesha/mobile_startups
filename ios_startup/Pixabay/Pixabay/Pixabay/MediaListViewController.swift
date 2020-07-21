//
//  MediaListViewController.swift
//  Pixabay
//
//  Created by Akerke Okapova on 4/18/18.
//  Copyright © 2018 Akerke Okapova. All rights reserved.
//

import UIKit

extension Constants {
    
    static let mediaInfoIdentifier = "ShowMediaInfo"
}

class MediaListViewController: UIViewController {

    @IBOutlet weak var imagesButton: UIButton!
    @IBOutlet weak var videosButton: UIButton!
    
    var mediaManager: MediaManager! {
        didSet{
            updateUI()
        }
    }
    
    private func configureSearchController(){
        if mediaManager.getMode() == Constants.favoritesMode {
            return
        }
        
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        searchController.delegate = self
        searchController.searchBar.delegate = self
        
    }
    
    func updateUI() {
        if checkString(searchString: mediaManager.getQueryString()){
            mediaManager.searchMedia()
        }
    }
    
    @IBAction func imagesButtonPressed(_ sender: Any) {
        mediaManager.setMediaMode(mode: Constants.mediaImageMode)
        updateUI()
    }
    
    @IBAction func videosButtonPressed(_ sender: Any) {
        mediaManager.setMediaMode(mode: Constants.mediaVideosMode)
        updateUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = mediaManager.getMode()
        configureSearchController()
        updateUI()
    }
}

extension MediaListViewController: UISearchBarDelegate, UISearchControllerDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.dismiss(animated: true, completion: nil)
        
        mediaManager.setQueryString(query: searchBar.text!)
        
        updateUI()
    }
    
    func checkString(searchString: String?) -> Bool {
        if let str = searchString {
            let trimmedStr = str.trimmingCharacters(in: .whitespacesAndNewlines)
            
            if trimmedStr != ""{
                return true
            }
        }
        return false
    }
}
