//
//  likesButton.swift
//  music-app
//
//  Created by melina  on 23.11.26.
//
import UIKit

extension UIViewController {
    func createLeftButton () {
        let customButton = UIBarButtonItem( image: UIImage(systemName: "heart.fill"), primaryAction: UIAction { _ in
            if let favoritesVC = self.storyboard?.instantiateViewController(identifier: "FavoritesViewController") as? FavoritesViewController {
                
                self.navigationController?.pushViewController(favoritesVC, animated: true)
                
            }
            
        })
        customButton.tintColor = .red
        navigationItem.leftBarButtonItem = customButton
    }
}
