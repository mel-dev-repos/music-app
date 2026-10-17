//
//  alertButton.swift
//  music-app
//
//  Created by melina  on 15.10.26.
//
import UIKit


extension UIViewController {
    
    func creatRightButton () {
        let customButton = UIBarButtonItem( image: UIImage(systemName: "square.and.arrow.up"), primaryAction: UIAction { _ in
            self.createAlert()
        })
        navigationItem.rightBarButtonItem = customButton
    }
    
    func createAlert () {
        let alert = UIAlertController(
            title: "دانلود اپ",
            message: "اپ رو دانلود کن",
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(title: "دانلود", style: .default) { _ in
            if let url = URL(string: "itms-apps://apps.apple.com/app/id324684580") {
                UIApplication.shared.open(url)
            }        })

        alert.addAction(UIAlertAction(title: "انصراف", style: .cancel) { _ in
            print("منصرف شد")
        })

        present(alert, animated: true)
    }
}
