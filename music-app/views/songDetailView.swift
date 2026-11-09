//
//  songDetailView.swift
//  music-app
//
//  Created by melina  on 15.10.26.
//

import UIKit
import SDWebImage
import AVFoundation

class SongViewDetail: UIViewController {
    
    var musicData : ResultData?
    var previewManager = PreviewManager()
    let player = AVPlayer()
    @IBOutlet weak var musicImage: UIImageView!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var songName: UILabel!
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        player.pause()
        
    }
    
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
        
        
        guard let music = musicData  else{
            return
        }
        previewManager.fetchPreview(songName: music.title, singer: music.artist) { previewUrl, error in
            
            DispatchQueue.main.async {
                if let error = error {
                    self.createErrorAlert(message: error.localizedDescription)
                    return
                }
                if let previewUrl = previewUrl {
                    if let url = URL(string: previewUrl) {
                        let avUrl = AVPlayerItem(url : url)
                        self.player.replaceCurrentItem(with: avUrl)
                        self.player.play()
                    }
                    
                }else {
                    self.createErrorAlert(message: "این موسیقی قابلیت پخش ندارد")
                }
                
            }
        }
        
        
    }
}



