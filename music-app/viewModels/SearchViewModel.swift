//
//  SearchViewModel.swift
//  music-app
//
//  Created by melina  on 12.10.26.
//

import Foundation

class SearchViewModel : MusicManagerDelegate {
    var resultsData : [ResultData]  = []
    
    var musicManager = MusicManager()
    
    let singers : [SingerData] = [
        SingerData(name: "Siavash Ghomayshi", image: "siavash_ghomayshi"),
        SingerData(name: "Ebi", image: "ebi"),
        SingerData(name: "Dariush", image: "dariush"),
        SingerData(name: "Googoosh", image: "googoosh"),
        SingerData(name: "Shadmehr Aghili", image: "shadmehr_aghili"),
        SingerData(name: "Taylor Swift", image: "taylor_swift"),
        SingerData(name: "Ed Sheeran", image: "ed_sheeran"),
        SingerData(name: "Adele", image: "adele"),
        SingerData(name: "The Weeknd", image: "the_weeknd"),
        SingerData(name: "Billie Eilish", image: "billie_eilish"),
        SingerData(name: "Drake", image: "drake"),
        SingerData(name: "Dua Lipa", image: "dua_lipa"),
        SingerData(name: "Coldplay", image: "coldplay"),
        SingerData(name: "Eminem", image: "eminem"),
        SingerData(name: "Ariana Grande", image: "ariana_grande")
    ]
    var onUpdate: (() -> Void)?
     
    var onError : ((String) -> Void)?
    
    init () {
        musicManager.delegate = self

    }
    
  
    
    func didUpdateMusic(results : [ResultData]) {
        resultsData = results + results
        onUpdate?()
            }
    
    func didGetError (error : Error) {
        onError?(error.localizedDescription)
        
    }
    
    func searchMusic (musicName: String) {
        musicManager.fetchMusic(musicName: musicName)

    }
    
}
