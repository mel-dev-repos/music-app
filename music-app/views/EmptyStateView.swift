//
//  EmptyStateView.swift
//  music-app
//
//  Created by melina  on 24.11.26.
//

import UIKit

class EmptyStateView: UIView {
    
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var button: UIButton!
    
    func configure (iconImageView : String , titleLabel :String , subtitleLabel : String , buttonTitle : String) {
        
        image.image = UIImage(named: iconImageView)
        title.text = titleLabel
        subtitle.text = subtitleLabel
        button.setTitle(buttonTitle, for: .normal)
        
    }
    
}
