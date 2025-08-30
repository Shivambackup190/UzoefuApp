import UIKit

class FilterVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var distanceDetailStack: UIStackView!
    @IBOutlet weak var categoryDetailStack: UIStackView!
    @IBOutlet weak var ratingDetailStack: UIStackView!
    @IBOutlet weak var priceDetailStack: UIStackView!
    
    @IBOutlet weak var distanceButton: UIButton!
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var ratingButton: UIButton!
    @IBOutlet weak var priceButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
