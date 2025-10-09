import UIKit
protocol DistanceTableViewCellDelegate: AnyObject {
    func showOptions(title: String, options: [String], onSelect: @escaping (String) -> Void)
}

class DistanceTableViewCell: UITableViewCell {
    var cities: [String] = []

    @IBOutlet weak var citiesLabel: UILabel!
    @IBOutlet weak var rangeLabel: UILabel!
    weak var delegate: DistanceTableViewCellDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Actions
    @IBAction func selectCityAction(_ sender: UIButton) {
        delegate?.showOptions(title: "Select City", options: cities) { selected in
            self.citiesLabel.text = selected
        }
    }
    
    @IBAction func selectRadiusAction(_ sender: UIButton) {
        delegate?.showOptions(title: "Select Radius",
                              options: ["5 Km", "10 Km", "15 Km", "20 Km"]) { selected in
            self.rangeLabel.text = selected
        }
    }
    
}
