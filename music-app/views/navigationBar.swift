//
//  navigationBar.swift
//  music-app
//
//  Created by melina  on 28.10.26.
//

import UIKit

extension UIViewController {
    
    func setUpNavigationBar () {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .secondarySystemBackground
        appearance.shadowColor = .separator
        
        navigationController?.navigationBar.standardAppearance = appearance
        
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
}
