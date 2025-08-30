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
        self.navigationController?.pushViewController(nav, animated: true)
    }
}
