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
    
    @IBOutlet weak var playPause: UIButton!
    var isPlaying = false
    var musicIndex = 0
    var resultData : [ResultData] = []
    var previewManager = PreviewManager()
    let player = AVPlayer()
    @IBOutlet weak var musicImage: UIImageView!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var songName: UILabel!
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        player.pause()
        isPlaying = false
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        musicImage.layer.cornerRadius = 24
        musicImage.clipsToBounds = true
        creatRightButton()
        
        if musicIndex >= resultData.count {
            return
        }
        updateUI(with:resultData[musicIndex])
        
        
    }
    
    func updatePlayIcon() {
        let name = isPlaying ? "pause.circle.fill" : "play.circle.fill"
        playPause.setImage(UIImage(systemName: name), for: .normal)
    }
    
    func updateUI(with music: ResultData) {
        artistName.text = music.artist
        songName.text = music.title
        
        let placeholder = UIImage(systemName: "music.note")
        if let image = music.image, let url = URL(string: image) {
            musicImage.sd_setImage(with: url, placeholderImage: placeholder)
        } else {
            musicImage.image = placeholder
        }
    }
    
    func playPreview(for music: ResultData) {
        previewManager.fetchPreview(songName: music.title, singer: music.artist) { previewUrl, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.createErrorAlert(message: error.localizedDescription)
                    return
                }
                guard let previewUrl = previewUrl, let url = URL(string: previewUrl) else {
                    self.createErrorAlert(message: "این موسیقی قابلیت پخش ندارد")
                    return
                }
                let item = AVPlayerItem(url: url)
                self.player.replaceCurrentItem(with: item)
                self.player.play()
            }
        }
       
    }
    
    @IBAction func rightButtonClicked(_ sender: UIButton) {
        guard musicIndex + 1 < resultData.count else { return }
        
        musicIndex += 1
        
        let selectedMusic = resultData[musicIndex]
        
        updateUI(with: selectedMusic)
        playPreview(for : selectedMusic )
        isPlaying = true
        updatePlayIcon()
        
        
    }
    
    @IBAction func leftButtonClicked(_ sender: UIButton) {
        if musicIndex <= 0 {
            return
        }
        musicIndex -= 1
        let selectedMusic = resultData[musicIndex]
        
        updateUI(with:selectedMusic )
        playPreview(for : selectedMusic )
        isPlaying = true
        updatePlayIcon()
    }
    
    
    @IBAction func playClicked(_ sender: UIButton) {
        
        let music = resultData[musicIndex]
     
      
        if isPlaying {
            player.pause()
        }
        else if player.currentItem != nil {
            player.play()
        }
        else {
            playPreview(for: music)
        }
        
        isPlaying.toggle()
        updatePlayIcon()
        
        
        
    }
}



