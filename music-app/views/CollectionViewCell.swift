//
//  CollectionViewCell.swift
//  music-app
//
//  Created by melina  on 22.11.26.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var singerImg: UIImageView!
    @IBOutlet weak var singerName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        singerImg.layer.cornerRadius = 35
        // Initialization code
    }
    func configure(singer : SingerData){
        
        singerName.text = singer.name
        singerImg.image = UIImage(named: singer.image)
    }
    
    
}

