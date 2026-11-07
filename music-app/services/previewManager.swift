//
//  previewManager.swift
//  music-app
//
//  Created by melina  on 06.11.26.
//

import Foundation

struct PreviewManager  {
    
    
    
    func fetchPreview (songName : String , singer : String) {
        
    let urlString = "https://itunes.apple.com/search?term=\(singer)+\(songName)&entity=song&limit=1"
        
        var url = URL(string: urlString)
        var urlRequest = URLRequest(url: url!)
        var session = URLSession(configuration: .default)
        let task =  session.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                self.createErrorAlert(message: error.localizedDescription)
            }
        }
        
        task.resume()
    }
    
    
    
    
}
