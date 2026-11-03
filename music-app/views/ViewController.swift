

import UIKit
import SDWebImage

class ViewController: UIViewController,UISearchBarDelegate, UISearchControllerDelegate {
 
    
    @IBOutlet weak var card: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet  var headerView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var topName: UILabel!
    @IBOutlet weak var singer: UILabel!
    
    var searchViewModel = SearchViewModel()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
       
    
        

        tableView.tableHeaderView = nil
        card.backgroundColor = UIColor(named: "customRed")
        card.layer.cornerRadius = 14
        card.clipsToBounds = true
        
        let tap = UITapGestureRecognizer(target:self, action: #selector(hideKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        setupSearch()
        // کلوژر viewModel
        searchViewModel.onUpdate = {
            
            self.tableView.reloadData()
            self.topName.text = self.searchViewModel.resultsData.first?.title
            self.singer.text = self.searchViewModel.resultsData.first?.artist
        }
        
        searchViewModel.onError = { errorTxt in
            self.createErrorAlert(message: errorTxt)
        }
        
        tableView.keyboardDismissMode = .onDrag
        tableView.dataSource = self
        tableView.delegate = self
        // ارتفاع هر سلول ۱۰۰ باشه
        tableView.rowHeight = 100
        navigationItem.backButtonTitle = "بازگشت"
        tableView.register(UINib(nibName: "songCell", bundle: nil), forCellReuseIdentifier: "songCell")
        setUpNavigationBar()
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if searchViewModel.resultsData.isEmpty {
            return nil
        } else {
            return headerView
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if searchViewModel.resultsData.isEmpty {
            return CGFloat.leastNormalMagnitude
        }else {
            return 200
        }
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
        searchBar.placeholder = "اسم آهنگ یا خواننده"
      searchBar.returnKeyType = .search

   
    }

    
}

