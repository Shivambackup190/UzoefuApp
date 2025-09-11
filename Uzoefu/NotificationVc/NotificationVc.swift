//
//  NotificationVc.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 11/09/25.
//

import UIKit

class NotificationVc: UIViewController {

    @IBOutlet weak var notificationTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "NotificationtableviewCell", bundle: nil)
        notificationTableView.register(nib, forCellReuseIdentifier: "NotificationtableviewCell")
        
        notificationTableView.delegate = self
        notificationTableView.dataSource = self

    }

    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
extension NotificationVc: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = notificationTableView.dequeueReusableCell(withIdentifier: "NotificationtableviewCell", for: indexPath) as! NotificationtableviewCell
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
    }
    
    
}


