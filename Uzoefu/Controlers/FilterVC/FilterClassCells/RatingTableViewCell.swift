import UIKit

class RatingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableHeightConstraint: NSLayoutConstraint!
    
    let ratings = ["All ratings", "1", "2", "3", "4", "5"]
    
    // ✅ multiple selection ke liye
    var selectedIndexes: Set<Int> = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        reloadTable()
        tableView.register(SearchRatingCell.self, forCellReuseIdentifier: "SearchRatingCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateTableHeight()
        
    }
    
    func updateTableHeight() {
        tableView.layoutIfNeeded()
        tableHeightConstraint.constant = tableView.contentSize.height
    }
    func reloadTable() {
        tableView.reloadData()
        DispatchQueue.main.async {
            self.updateTableHeight()
        }
    }

}

extension RatingTableViewCell: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ratings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchRatingCell", for: indexPath) as! SearchRatingCell
        cell.selectionStyle = .none
        cell.configure(with: ratings[indexPath.row], isSelected: selectedIndexes.contains(indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            // ✅ "All ratings" selected → sab select karo
            if selectedIndexes.contains(0) {
                // already selected → clear all
                selectedIndexes.removeAll()
            } else {
                // select all
                selectedIndexes = Set(0..<ratings.count)
            }
        } else {
            // ✅ individual rating toggle
            if selectedIndexes.contains(indexPath.row) {
                selectedIndexes.remove(indexPath.row)
            } else {
                selectedIndexes.insert(indexPath.row)
            }
            
            // Agar sab individual selected hain → "All ratings" bhi tick ho
            if selectedIndexes.count == ratings.count - 1 {
                selectedIndexes = Set(0..<ratings.count)
            } else {
                selectedIndexes.remove(0) // "All ratings" untick karo
            }
        }
        
        tableView.reloadData()
        updateTableHeight()
    }
}
