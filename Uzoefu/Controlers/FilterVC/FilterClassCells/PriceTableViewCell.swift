//
//  PriceTableViewCell.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 10/09/25.
//

import UIKit

class PriceTableViewCell: UITableViewCell {
    
    @IBOutlet weak var tableView: UITableView!

    
    @IBOutlet weak var tableHeightConstraint: NSLayoutConstraint!
    let prices = [
        "0 - 150",
        "151 - 300",
        "301 - 450",
        "451 - 600",
        "601 - 750",
        "751 - 900",
        "901 +"
    ]
 
    var selectedIndexes: Set<Int> = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tableView.register(PriceSearchCell.self, forCellReuseIdentifier: "PriceSearchCell")
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
}

extension PriceTableViewCell: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return prices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PriceSearchCell", for: indexPath) as! PriceSearchCell
        cell.selectionStyle = .none
        cell.configure(with: prices[indexPath.row], isSelected: selectedIndexes.contains(indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    
        if selectedIndexes.contains(indexPath.row) {
            selectedIndexes.remove(indexPath.row)
        } else {
            selectedIndexes.insert(indexPath.row)
        }
        
        tableView.reloadData()
        updateTableHeight()
    }
}
