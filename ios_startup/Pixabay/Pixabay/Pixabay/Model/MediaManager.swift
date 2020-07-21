//
//  MediaManager.swift
//  Pixabay
//
//  Created by Akerke Okapova on 4/18/18.
//  Copyright © 2018 Akerke Okapova. All rights reserved.
//

import Foundation

struct Constants {
    
    static let searchMode = "Search"
    static let favoritesMode = "Favorites"
    
    static let mediaImagesMode = "Images"
    static let mediaVideosMode = "Videos"
    
    static let urls = [
        mediaImagesMode: Urls.imageUrl,
        mediaVideosMode: Urls.videoUrl,
    ]
}

struct MediaManager {
    
    private var mode: String = Constants.searchMode
    private var mediaMode: String = Constants.mediaImagesMode
    private var imageList: [Image] = []
    private var videoList: [Video] = []
    private var queryString: String = ""
    
    func searchMedia(){
        
    }
    
    mutating func setMode(mode: String){
        self.mode = mode
    }
    
    func getMode() -> String{
        return self.mode
    }
    
    mutating func setMediaMode(mode: String){
        self.mediaMode = mode
    }
    
    func getMediaMode() -> String{
        return self.mediaMode
    }
    
    mutating func setQueryString(query: String){
        self.queryString = query
    }
    
    func getQueryString() -> String{
        return self.queryString
    }
}
