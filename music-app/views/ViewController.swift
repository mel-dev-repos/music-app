

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
var musicManager = MusicManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemCyan
        
        searchTextField.delegate = self
        searchButton.backgroundColor = .systemPink
        searchButton.setTitle("show me...", for:.normal)
        searchButton.setTitle("Loading...", for: .highlighted)
        searchButton.frame.size.width = 120
        searchButton.tintColor = .white
        searchTextField.layer.cornerRadius = 10
        searchTextField.clipsToBounds = true
        searchTextField.placeholder = "search a good one:)"

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


