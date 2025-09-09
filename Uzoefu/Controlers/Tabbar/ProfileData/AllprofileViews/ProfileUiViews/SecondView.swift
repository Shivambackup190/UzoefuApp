import UIKit

class SecondView: UIView {
    
    @IBOutlet weak var rangeTextField: FloatingTextField!
    @IBOutlet weak var selectFoavariteCollection: UICollectionView!
    var nearloactionBtn : (()->()) = {}
    
    @IBAction func nearBtnAction(_ sender: UIButton) {
        nearloactionBtn()
    }
}

