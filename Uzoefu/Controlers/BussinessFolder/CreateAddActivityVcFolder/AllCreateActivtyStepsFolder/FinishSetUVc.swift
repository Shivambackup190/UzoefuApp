//
//  FinishSetUVc.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 04/09/25.
//

import UIKit

class FinishSetUVc: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

      
    }
    
    @IBAction func backActionBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func ViewActityActionBtn(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "BusinessCompanyDetailsVc") as! BusinessCompanyDetailsVc
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func addActivityActionBtn(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CreateAddActivityVc") as! CreateAddActivityVc
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
