//
//  InformationClassUiView.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 19/08/25.
//

import UIKit

class InformationClassUiView: UIView {
    @IBOutlet weak var informationTbale: UITableView!
    var BookingActionBtnInformation : (()->()) = {}
    @IBOutlet weak var bookAction: UIButton!
    
    @IBAction func BookActionBtn(_ sender: UIButton) {
        BookingActionBtnInformation()
    }
    
}


     
