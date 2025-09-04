//
//  BussniessActivitiesClass.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 04/09/25.
//

import UIKit

class BussniessActivitiesClass: UIView {

    var AddmoreActionBtn : (()->()) = {}
    @IBOutlet weak var BussnessActivityTableView: UITableView!
    
    @IBAction func AddmoreActionBtn(_ sender: UIButton) {
        AddmoreActionBtn()
    }
}
