//
//  FavoritesViewController.swift
//  music-app
//
//  Created by melina  on 23.11.26.
//

import UIKit

class FavoritesViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    let favoriteSongs = FavoriteSongManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "songCell", bundle: nil), forCellReuseIdentifier: "songCell")
        updateUI()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favoriteSongs.getItems().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath) as! SongCell
        
        
        let song = favoriteSongs.getItems()[indexPath.row]

          cell.configure(with: song)
        
        return cell
        
    }
    
    
    
    
  
    func updateUI() {
        
        let songs = favoriteSongs.getItems()
        
        if songs.isEmpty {
            
            let emptyView = Bundle.main.loadNibNamed(
                "EmptyStateView",
                owner: nil
            )?.first as! EmptyStateView
            
            emptyView.frame = tableView.bounds
            
            emptyView.configure(
                iconImageView: "heart.fill",
                titleLabel: "موسیقی مورد علاقه ای ندارید؟",
                subtitleLabel: "در صفحه جزئیات قلب رو قرمز کنید:)",
                buttonTitle: "جستجو"
            )
            
            
            
            tableView.backgroundView = emptyView
            
        } else {
            
            tableView.backgroundView = nil
        }
        
        tableView.reloadData()
    }
    
    
    
}
