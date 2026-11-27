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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailVC = storyboard?.instantiateViewController(identifier: "SongViewDetail") as? SongViewDetail else {return}
        
        detailVC.musicIndex = indexPath.row
        detailVC.resultData = favoriteSongs.getItems()
        navigationController?.pushViewController(detailVC, animated: true)
        
        
        
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let remove = UIContextualAction(style: .destructive, title: "حذف") { action, view, completion in
            let song = self.favoriteSongs.getItems()[indexPath.row]
            self.favoriteSongs.unlike(item: song)
            if self.favoriteSongs.getItems().isEmpty {
                self.updateUI()
            }else {
                tableView.deleteRows(at: [indexPath], with: .automatic)
                
            }
            completion(true)
        }
        remove.backgroundColor = .systemRed
        return UISwipeActionsConfiguration(actions: [remove])
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
