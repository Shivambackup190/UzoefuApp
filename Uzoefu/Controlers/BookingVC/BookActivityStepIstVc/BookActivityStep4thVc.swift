//
//  BookActivityStep4thVc.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 26/08/25.
//

import UIKit

class BookActivityStep4thVc: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    
    @IBAction func confirmBtnAction(_ sender: UIButton) {
        let nav = self.storyboard?.instantiateViewController(withIdentifier: "BookActivityStep5thVc") as! BookActivityStep5thVc
        self.navigationController?.pushViewController(nav, animated: false)
    }
    
}
