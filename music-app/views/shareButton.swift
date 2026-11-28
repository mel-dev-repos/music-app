//
//  shareButton.swift
//  music-app
//
//  Created by melina  on 28.11.26.
//

import UIKit

extension UIViewController {
    
    func share (music  : ResultData){
        let baseUrl = "https://open.spotify.com/track/"
        guard let url = URL(string: "\(baseUrl)\(music.id)") else {return}
        
        
        let activityVC = UIActivityViewController(
            activityItems: [url],
            applicationActivities: nil
        )
        
        present(activityVC, animated: true)
        
    }
    
    
}
