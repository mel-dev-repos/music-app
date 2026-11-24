//
//  favoriteSongsManager.swift
//  music-app
//
//  Created by melina  on 23.11.26.
//

import Foundation


struct FavoriteSongManager {
    let key = "favorites"
    let userDefaults = UserDefaults.standard
    let jsonDecoder = JSONDecoder()
    let jsonEncoder = JSONEncoder()
    
    
    
    func saveItems (item: [ResultData]) {
        
        do {
            let encodedItems = try jsonEncoder.encode(item)
            userDefaults.set(encodedItems, forKey: key)
        }
        catch {
            print(error)
        }
    }
    
    func getItems () -> [ResultData] {
        guard let data = userDefaults.data(forKey: key) else {
            return []
        }
        
        
        
        do {
            let items = try jsonDecoder.decode( [ResultData].self , from:data )
            return items
        }
        catch {
            print("somthing bad happened")
            return []
        }
        
    }
    
    func like (item : ResultData) {
        let likes = getItems()
        
        if isLiked(item: item) {
            
            return
            
        } else {
            let newLikes = likes + [item]
            saveItems(item: newLikes )
            
            
            
        }
        
        
        
    }
    func unlike (item : ResultData) {
        let likes = getItems()
        let newLikes = likes.filter {$0.id != item.id}
        saveItems(item: newLikes)
    }
    
    func isLiked (item : ResultData) -> Bool {
        let likes = getItems()
        
        return likes.contains(where: {$0.id == item.id} )
        
    }
}
