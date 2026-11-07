//
//  songDetailView.swift
//  music-app
//
//  Created by melina  on 15.10.26.
//

import UIKit
import SDWebImage

    
    class SongViewDetail: UIViewController {
        
        var musicData : ResultData?
        @IBOutlet weak var musicImage: UIImageView!
        @IBOutlet weak var artistName: UILabel!
        @IBOutlet weak var songName: UILabel!
        override func viewDidLoad() {
            super.viewDidLoad()
        
           
            
            musicImage.layer.cornerRadius = 24
            musicImage.clipsToBounds = true
            
            let placeholder = UIImage(systemName: "music.note")
            
            if let music = musicData {
                artistName.text = music.artist
                songName.text = music.title
                
                if let image = music.image, let url = URL(string: image) {
                    musicImage.sd_setImage(with: url, placeholderImage: placeholder)
                    

                }else {
                    musicImage.image = placeholder
                }
                
                
                  
            }
            
           
              

            

            creatRightButton()
        }
        
        @IBAction func playClicked(_ sender: UIButton) {
        }
    }
  
 
  
