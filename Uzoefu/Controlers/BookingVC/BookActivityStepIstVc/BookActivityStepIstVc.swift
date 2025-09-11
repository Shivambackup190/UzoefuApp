//
//  BookActivityStepIstVc.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 25/08/25.
//

import UIKit

class BookActivityStepIstVc: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func nextBtnAction(_ sender: Any) {
        let nav = self.storyboard?.instantiateViewController(withIdentifier: "BookActivityStep2ndVc") as! BookActivityStep2ndVc
        self.navigationController?.pushViewController(nav, animated: false)
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func notificationAction(_ sender: Any) {
        let nav = self.storyboard?.instantiateViewController(withIdentifier: "NotificationVc") as! NotificationVc
              self.navigationController?.pushViewController(nav, animated: true)
    }
}
