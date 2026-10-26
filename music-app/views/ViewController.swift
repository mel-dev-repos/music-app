

import UIKit
import SDWebImage

class ViewController: UIViewController,UISearchBarDelegate, UISearchControllerDelegate {
 
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var songName: UILabel!
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var searchViewModel = SearchViewModel()
    
    override func viewDidLoad() {
        
        
        
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target:self, action: #selector(hideKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        setupSearch()
        searchViewModel.onUpdate = {
            self.tableView.reloadData()
        }
        tableView.keyboardDismissMode = .onDrag
        tableView.dataSource = self
        tableView.delegate = self
        // ارتفاع هر سلول ۱۰۰ باشه
        tableView.rowHeight = 100
        headerImage.frame.size.height = 200
        navigationItem.backButtonTitle = "بازگشت"
        tableView.register(UINib(nibName: "songCell", bundle: nil), forCellReuseIdentifier: "songCell")

        creatRightButton()
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchBar.becomeFirstResponder()
    }
    
    @objc func hideKeyboard () {
        view.endEditing(true)
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text , !text.isEmpty {
            searchViewModel.searchMusic(musicName: text)

        }
        searchBar.resignFirstResponder()

    }
   
  
}



extension ViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return searchViewModel.resultsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath) as! SongCell

        if indexPath.row == 0 {
            cell.backgroundColor = UIColor.systemRed.withAlphaComponent(0.15)
        } else {
            cell.backgroundColor = .systemBackground
        }

        cell.configure(with: searchViewModel.resultsData[indexPath.row])
        return cell
    }
    
    
    
    
    
    
}

extension ViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "songDetail", sender: indexPath)
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "songDetail" {
            let detailVc = segue.destination as! SongViewDetail
           
        }
    }
    
    
    
    //اضافه کردن همه فیچرهای uisearch
    func setupSearch() {
        // وصل کردن به صفحه
        searchBar.delegate = self

        // همیشه دیده شود، حتی موقع اسکرول
        navigationItem.hidesSearchBarWhenScrolling = false

        // موقع تایپ، صفحه تیره نشود

//ادیت خودکار و کپتال کردن هم غیرفعال
        searchBar.autocapitalizationType = .none
        searchBar.autocorrectionType = .no

      searchBar.returnKeyType = .search

        // دکمه‌های فیلتر زیر سرچ‌بار
        searchBar.showsScopeBar = true
    searchBar.scopeButtonTitles = ["آهنگ", "خواننده"]
    }

    
}

