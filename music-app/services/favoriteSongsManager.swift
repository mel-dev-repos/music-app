//
//  favoriteSongsManager.swift
//  music-app
//
//  Created by melina  on 23.11.26.
//

import UIKit


struct FavoriteSongManager {
    let key = "favorites"
    let userDefaults = UserDefaults.standard
    
    
    
    func getItems () -> [String] {
        let items =  userDefaults.stringArray(forKey: key) ?? []
        return items
    }
    
    func like (id : String) {
        let likes = getItems()
        if likes.contains(id) {
            return
        }
        else {
            let newLikes = likes + [id]
            userDefaults.set(newLikes, forKey: key)
        }
    
    }
    func unlike (id : String) {
        let likes = getItems()
        let newLikes = likes.filter {$0 != id}
        userDefaults.set(newLikes, forKey: key)
    }
    
    func isLiked (id : String) -> Bool {
        let likes = getItems()
        
        return likes.contains(id)
        
    }
}
