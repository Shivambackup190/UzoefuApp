//
//  ReviewVcClass.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 05/09/25.
//

import UIKit

class ReviewVcClass: UIViewController,CustomDropdownDelegate  {
    
    @IBOutlet weak var fiveStarProgress: UIProgressView!
    @IBOutlet weak var fourStarProgress: UIProgressView!
    @IBOutlet weak var threeStarProgress: UIProgressView!
    @IBOutlet weak var twoStarProgress: UIProgressView!
    @IBOutlet weak var oneStarProgress: UIProgressView!
    
    @IBOutlet weak var reviewTableView: UITableView!
    
    @IBOutlet weak var demoView: UIView!
    @IBOutlet weak var ratingLabel: UITextField!
    @IBOutlet weak var clickDropdownBtn: UIButton!
    var dropdown: CustomDropdown!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reviewTableView.register(UINib(nibName: "ReviewVcClassTableviewCell", bundle: nil), forCellReuseIdentifier: "ReviewVcClassTableviewCell")
        reviewTableView.separatorStyle = .none
        reviewTableView.showsHorizontalScrollIndicator = false
        reviewTableView.showsVerticalScrollIndicator = false
        
        // Example data
        let totalReviews: Float = 500
        let fiveStar: Float = 400
        let fourStar: Float = 300
        let threeStar: Float = 200
        let twoStar: Float = 100
        let oneStar: Float = 50
        
       
        fiveStarProgress.progress = fiveStar / totalReviews
        fourStarProgress.progress = fourStar / totalReviews
        threeStarProgress.progress = threeStar / totalReviews
        twoStarProgress.progress = twoStar / totalReviews
        oneStarProgress.progress = oneStar / totalReviews
        
        fiveStarProgress.progressTintColor = .systemYellow
        fourStarProgress.progressTintColor = .systemYellow
        threeStarProgress.progressTintColor = .systemYellow
        twoStarProgress.progressTintColor = .systemYellow
        oneStarProgress.progressTintColor = .systemYellow
        
      
        fiveStarProgress.trackTintColor =  .clear
        fourStarProgress.trackTintColor = .clear
        threeStarProgress.trackTintColor = .clear
        twoStarProgress.trackTintColor =  .clear
        oneStarProgress.trackTintColor = .clear
        dropdown = CustomDropdown(anchorView: demoView,
                                        options: ["1 Star", "2 Star", "3 Star", "4 Star", "5 Star"])
              dropdown.delegate = self
    }
    @IBAction func selectRatingAction(_ sender: Any) {
        dropdown.toggleDropdown(in: self.view)
    }
    // MARK: - Dropdown Delegate
        func dropdown(_ dropdown: CustomDropdown, didSelectOption option: String, at index: Int) {
            print("Selected: \(option) at index: \(index)")
            ratingLabel.text = option

        }
}
extension ReviewVcClass: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = reviewTableView.dequeueReusableCell(withIdentifier: "ReviewVcClassTableviewCell", for: indexPath) as! ReviewVcClassTableviewCell
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
}


