import UIKit

class ExporeCategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var viewlayer: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViewLayer()
    }
    
    private func setupViewLayer() {
        viewlayer.layer.cornerRadius = 10
        viewlayer.layer.borderWidth = 0.5
        viewlayer.layer.borderColor = UIColor.lightGray.cgColor
        viewlayer.layer.shadowColor = UIColor.gray.cgColor
        viewlayer.layer.shadowOffset = CGSize(width: 0, height: 0)
        viewlayer.layer.shadowRadius = 2
        viewlayer.layer.shadowOpacity = 0.3
        viewlayer.layer.masksToBounds = false
    }
}
