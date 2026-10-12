

import UIKit
import SDWebImage

class ViewController: UIViewController,UITextFieldDelegate {
 
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var songName: UILabel!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!

var searchViewModel = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchViewModel.onUpdate = {
            self.tableView.reloadData()
        }
        tableView.delegate = self
        tableView.dataSource = self
        searchTextField.delegate = self
        searchTextField.placeholder = "Artists ,songs"
        searchTextField.layer.cornerRadius = 10
        searchTextField.clipsToBounds = true
        searchButton.tintColor = .white
        searchButton.backgroundColor = .accentPink
    }

  
   
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)

        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "enter a music name"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let music = searchTextField.text  {
            searchViewModel.searchMusic(musicName:music)
        }
 
        
        searchTextField.text = ""
    }
}



extension ViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchViewModel.resultsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath)
        let resultRowPath = searchViewModel.resultsData[indexPath.row]
        cell.textLabel?.text = resultRowPath.title
        cell.detailTextLabel?.text = resultRowPath.artist
        let placeholder = UIImage(systemName: "music.note")
        if let image = resultRowPath.image, let url = URL(string: image) {
            cell.imageView?.sd_setImage(with: url,placeholderImage: placeholder)
        }else {
            cell.imageView?.image = placeholder
        }
            
            return cell
    }
    
  
}

extension ViewController : UITableViewDelegate{
    
}
