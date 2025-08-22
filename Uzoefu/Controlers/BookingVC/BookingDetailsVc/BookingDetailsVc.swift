//
//  BookingDetailsVc.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 20/08/25.
//

import UIKit

class BookingDetailsVc: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
