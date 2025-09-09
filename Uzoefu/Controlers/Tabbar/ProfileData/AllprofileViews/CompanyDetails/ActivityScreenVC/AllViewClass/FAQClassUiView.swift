//
//  FAQClassUiView.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 19/08/25.
//

import UIKit

class FAQClassUiView: UIView {
var BookingActionBtnfaq : (()->()) = {}

    @IBOutlet weak var faqTableView: UITableView!
    
    @IBAction func faqActionBtn(_ sender: UIButton) {
        BookingActionBtnfaq()
    }
}
