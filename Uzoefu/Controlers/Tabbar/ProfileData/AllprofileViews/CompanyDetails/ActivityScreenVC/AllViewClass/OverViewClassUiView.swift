//
//  OverViewClassUiView.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 19/08/25.
//

import UIKit
import Cosmos

class OverViewClassUiView: UIView {
    var BookingActionBtn : (()->()) = {}

    @IBOutlet weak var descriptionTextLable: UILabel!
    @IBOutlet weak var highlight1: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var bokingActionButton: UIButton!
    
    @IBOutlet weak var celllarNumber: UILabel!
    @IBOutlet weak var telphonenumber: UILabel!
    @IBOutlet weak var branchAndaddressLabel: UILabel!
    @IBOutlet weak var highlight3: UILabel!
    @IBOutlet weak var hightLight2: UILabel!

    @IBAction func bookAction(_ sender: UIButton) {
        BookingActionBtn()
    }
}
