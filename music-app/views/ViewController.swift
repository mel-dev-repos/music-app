

import UIKit
import SDWebImage

class ViewController: UIViewController,UITextFieldDelegate,MusicManagerDelegate {
 
    var resultsData : [ResultData] = []
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var songName: UILabel!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
var musicManager = MusicManager()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        searchTextField.delegate = self
        musicManager.delegate = self
        searchButton.backgroundColor = .systemPink
        searchButton.setTitle("show me...", for:.normal)
        searchButton.setTitle("Loading...", for: .highlighted)
        searchButton.frame.size.width = 120
        searchButton.tintColor = .white
        searchTextField.layer.cornerRadius = 10
        searchTextField.clipsToBounds = true
        searchTextField.placeholder = "search a good one:)"

    }                                                                              

    func didUpdateMusic(results : [ResultData]) {
        resultsData = results
        tableView.reloadData()
        
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
            musicManager.fetchMusic(musicName:music)
        }
 
        
        searchTextField.text = ""
    }
}



extension ViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath)
        let resultRowPath = resultsData[indexPath.row]
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
