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
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var button: UIButton!
    
    func configure (iconImageView : String , titleLabel :String , subtitleLabel : String , buttonTitle : String? = nil) {
        view.layer.cornerRadius = 48
        image.image = UIImage(systemName:  iconImageView)
        title.text = titleLabel
        subtitle.text = subtitleLabel
        if let buttonTitle   {
            button.setTitle(buttonTitle, for: .normal)
            button.isHidden = false
        }else {
            button.isHidden = true
        }
   
        
    }
    
}
