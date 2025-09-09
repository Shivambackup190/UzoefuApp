//
//  ReviewsClassUiView.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 19/08/25.
//

import UIKit

class ReviewsClassUiView: UIView {
    var writereviewbtnAction : (()->()) = {}

    @IBOutlet weak var ReviewsTableView: UITableView!
    
    @IBOutlet weak var writeRevieButton: UIButton!
    
    @IBAction func writeRevieButton(_ sender: UIButton) {
        writereviewbtnAction()
    }
}
