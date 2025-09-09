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

    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var bokingActionButton: UIButton!
    
    @IBAction func bookAction(_ sender: UIButton) {
        BookingActionBtn()
    }
}
