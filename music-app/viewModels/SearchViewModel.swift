//
//  SearchViewModel.swift
//  music-app
//
//  Created by melina  on 12.10.26.
//

import Foundation

class SearchViewModel : MusicManagerDelegate {
    var resultsData : [ResultData] = []
    
    var musicManager = MusicManager()
    
    var onUpdate: (() -> Void)?
    
    var onError : ((String) -> Void)?
    
    init () {
        musicManager.delegate = self

    }
    
  
    
    func didUpdateMusic(results : [ResultData]) {
        resultsData = results
        onUpdate?()
            }
    
    func didGetError (error : Error) {
        onError?(error.localizedDescription)
        
    }
    
    func searchMusic (musicName: String) {
        musicManager.fetchMusic(musicName: musicName)

    }
    
}
