//
//  WishListVC.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 12/08/25.
//

import UIKit

class WishListVC: UIViewController {
    var hidevalue:String?

    @IBOutlet weak var weidthBackConstraint: NSLayoutConstraint!
    @IBOutlet weak var backHideShowBtn: UIButton!
    @IBOutlet weak var wishListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if hidevalue == "ok" {
            backHideShowBtn.isHidden = false
            weidthBackConstraint.constant = 40
        }
        else {
            backHideShowBtn.isHidden = true
            weidthBackConstraint.constant = 0
        }
        
     
        let nib = UINib(nibName: "WishListTableViewCell", bundle: nil)
        wishListTableView.register(nib, forCellReuseIdentifier: "cell")
        
        wishListTableView.delegate = self
        wishListTableView.dataSource = self
    }
    
    @IBAction func backActionBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension WishListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = wishListTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WishListTableViewCell
        return cell
        }
      
        
    }
    
 
