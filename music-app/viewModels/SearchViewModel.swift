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
    
    init () {
        musicManager.delegate = self

    }
    
  
    
    func didUpdateMusic(results : [ResultData]) {
        resultsData = results
        onUpdate?()
            }
    
    func searchMusic (musicName: String) {
        musicManager.fetchMusic(musicName: musicName)

    }
    
}
