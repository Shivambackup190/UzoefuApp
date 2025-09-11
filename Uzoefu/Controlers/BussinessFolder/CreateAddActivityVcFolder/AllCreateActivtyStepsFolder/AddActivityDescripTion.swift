import UIKit

class AddActivityDescripTion: UIViewController, UITextViewDelegate {

    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    @IBOutlet weak var highlightTbale: UITableView!
    @IBOutlet weak var charCountLabel: UILabel!
    @IBOutlet weak var descriptionText: UITextView!
    
    
    @IBOutlet weak var highlightTableHeight: NSLayoutConstraint!
    
    let wordLimit = 80
    var highlights: [String] = [""]
    override func viewDidLoad() {
        super.viewDidLoad()
        highlightTbale.rowHeight = UITableView.automaticDimension
       highlightTbale.estimatedRowHeight = 45
        highlightTbale.dataSource = self
        highlightTbale.delegate = self
        
        descriptionText.delegate = self
        charCountLabel.text = "0/\(wordLimit)"
        
        
        let layout1 = UICollectionViewFlowLayout()
        layout1.scrollDirection = .vertical
        categoriesCollectionView.collectionViewLayout = layout1
        categoriesCollectionView.showsHorizontalScrollIndicator = false
        
        categoriesCollectionView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        
        
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize" {
            collectionViewHeight.constant = categoriesCollectionView.collectionViewLayout.collectionViewContentSize.height
        }
    }

//    deinit {
//        categoriesCollectionView.removeObserver(self, forKeyPath: "contentSize")
//    }
    
    func textViewDidChange(_ textView: UITextView) {
       
        let words = textView.text
            .split { $0 == " " || $0.isNewline }
        
        let count = words.count
        
        if count > wordLimit {
           
            let limitedWords = words.prefix(wordLimit)
            textView.text = limitedWords.joined(separator: " ")
            charCountLabel.text = "\(wordLimit)/\(wordLimit)"
        } else {
            charCountLabel.text = "\(count)/\(wordLimit)"
        }
    }
    @IBAction func backActionBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
extension AddActivityDescripTion: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return highlights.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HighlightCell", for: indexPath) as? HighlightCell else {
            return UITableViewCell()
        }
        
        cell.textField.text = highlights[indexPath.row]

        
      
        cell.addRemoveAction = { [weak self] in
            guard let self = self else { return }
            
            if indexPath.row == self.highlights.count - 1 && self.highlights.count < 5 {
               
                self.highlights.append("")
            } else {
              
                self.highlights.remove(at: indexPath.row)
            }
            self.highlightTbale.reloadData()
            self.updateTableHeight()
        }
        
      
        if indexPath.row == highlights.count - 1 && highlights.count < 5 {
           
            cell.actionButton.setImage(UIImage(named: "plusIcon"), for: .normal)
        } else {
            cell.actionButton.setImage(UIImage(named: "minusRed"), for: .normal)
        }
        cell.selectionStyle = .none
        return cell
    }
    func updateTableHeight() {
        highlightTableHeight.constant = CGFloat(highlights.count * 55)
        view.layoutIfNeeded()
    }
}
extension AddActivityDescripTion: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = categoriesCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
    }
    
    // MARK: - Flow Layout
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemsPerRow: CGFloat = 3
        let spacing: CGFloat = 5
        let sectionInsets: CGFloat = 10
        
    
        let totalSpacing = (itemsPerRow - 1) * spacing + (sectionInsets * 2)
        
        let width = (collectionView.bounds.width - totalSpacing) / itemsPerRow
        
        return CGSize(width: width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
//    }
}



