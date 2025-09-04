//
//  SetupprofileVc.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 01/09/25.
//

import UIKit

class SetupprofileVc: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    

    @IBAction func backAction(_ sender: UIButton) {
    self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func addActivitiesAction(_ sender: UIButton) {
        let nav = self.storyboard?.instantiateViewController(withIdentifier: "CreateAddActivityVc") as!
        CreateAddActivityVc
        self.navigationController?.pushViewController(nav, animated: true)
        
    }
}
