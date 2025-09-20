import UIKit

class SecondView: UIView {
    
    
    @IBOutlet weak var firstNameLable: FloatingTextField!
    
    @IBOutlet weak var lastNameLable: FloatingTextField!
    
    @IBOutlet weak var fullnameTxt: FloatingTextField!
    
    @IBOutlet weak var mobiletf: FloatingTextField!
    
    @IBOutlet weak var addressTf: FloatingTextField!
    @IBOutlet weak var emailTf: FloatingTextField!
    
    @IBOutlet weak var dobTf: FloatingTextField!
    @IBOutlet weak var rangeTextField: FloatingTextField!
    @IBOutlet weak var selectFoavariteCollection: UICollectionView!
    var nearloactionBtn : (()->()) = {}
    var profileSaveBtnAction : (()->()) = {}
    
    @IBAction func nearBtnAction(_ sender: UIButton) {
        nearloactionBtn()
    }
    
    @IBAction func profileSaveBtnAction(_ sender: UIButton) {
        profileSaveBtnAction()
    }
}

