

import UIKit
import SDWebImage

class ViewController: UIViewController,UISearchBarDelegate, UISearchControllerDelegate {
 
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var songName: UILabel!
    @IBOutlet weak var headerImage: UIImageView!
    
    var searchViewModel = SearchViewModel()
    let searchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearch()
        searchViewModel.onUpdate = {
            self.tableView.reloadData()
        }
        tableView.dataSource = self
        tableView.delegate = self
        // ارتفاع هر سلول ۱۰۰ باشه
        tableView.rowHeight = 100
        headerImage.frame.size.height = 200
        navigationItem.backButtonTitle = "بازگشت"
        
        creatRightButton()
        searchController.hidesNavigationBarDuringPresentation = false
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
       
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath)
        let firstIndexPath = IndexPath(row:0,section: 0)
        
        //اولین سلول بک گراندش قرمز باشه
        if indexPath == firstIndexPath {
            cell.backgroundColor = .systemRed
        } else {
            cell.backgroundColor = .white
        }
 
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.keyboardDismissMode = .onDrag

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
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self

        // همیشه دیده شود، حتی موقع اسکرول
        navigationItem.hidesSearchBarWhenScrolling = false

        // موقع تایپ، صفحه تیره نشود
        searchController.obscuresBackgroundDuringPresentation = false

        searchController.searchBar.placeholder = "اسم آهنگ یا خواننده"
//ادیت خودکار و کپتال کردن هم غیرفعال
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.autocorrectionType = .no

        searchController.searchBar.returnKeyType = .search

        // دکمه‌های فیلتر زیر سرچ‌بار
        searchController.searchBar.scopeButtonTitles = ["آهنگ", "خواننده"]
    }

    
}

