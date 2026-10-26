//
//  songCell.swift
//  music-app
//
//  Created by melina  on 26.10.26.
//

import UIKit
import SDWebImage

class SongCell: UITableViewCell {
    @IBOutlet weak var artworkImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    
    //فانکشن وقتی که سلول ساخته میشه
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    func configure(with song: ResultData) {
        titleLabel.text = song.title
        artistLabel.text = song.artist

        let placeholder = UIImage(systemName: "music.note")
        if let image = song.image, let url = URL(string: image) {
            artworkImageView.sd_setImage(with: url, placeholderImage: placeholder)
        } else {
            artworkImageView.image = placeholder
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        artworkImageView.image = nil
    }
    
}
