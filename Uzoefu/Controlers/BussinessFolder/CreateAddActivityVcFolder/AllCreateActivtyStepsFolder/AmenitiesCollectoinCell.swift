import UIKit

class AmenitiesCollectoinCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var checkImage: UIImageView!
    @IBOutlet weak var checkButton: UIButton!
    
    var isChecked = false {
        didSet {
            checkImage.image = UIImage(named: isChecked ? "selectedImg" : "check square unselected")
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        isChecked = false
    }

    @IBAction func checkButtonTapped(_ sender: UIButton) {
        isChecked.toggle()
    }
}
