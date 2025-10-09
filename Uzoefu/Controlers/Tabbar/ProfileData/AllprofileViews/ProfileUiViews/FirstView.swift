import UIKit

class FirstView: UIView {
   
    
    @IBOutlet weak var proeditBtn: UIButton!
  
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var nikNameLabl: UILabel!
    @IBOutlet weak var profileImageOutLet: UIImageView!
    
    @IBOutlet weak var wishListCount: UILabel!
    
    @IBOutlet weak var bookingCount: UILabel!
    
    @IBOutlet weak var tripsCount: UILabel!
    
    @IBOutlet weak var photosCount: UILabel!
    @IBOutlet weak var rewardCount: UILabel!
    @IBOutlet weak var reviewsCount: UILabel!
    @IBOutlet weak var visitedCount: UILabel!
    var BookingAction : (()->()) = {}
    var WishListAction : (()->()) = {}
    var profileDetailsActionBtn : (()->()) = {}
    var logOutActionAction : (()->()) = {}
    var TermsActionBtn : (()->()) = {}
    var privacyActionBtn : (()->()) = {}
    
    var profileeditBtn : (()->()) = {}
    
    var profileimageChangeActionAction : (()->()) = {}
    @IBAction func bookingActionButton(_ sender: Any) {
        BookingAction()
    }
    
    @IBAction func wishListAction(_ sender: UIButton) {
        WishListAction()
    }
    
    
    @IBAction func logoutAction(_ sender: Any) {
        logOutActionAction()
    }
    
    @IBAction func profileImageChangeBtn(_ sender: UIButton) {
        profileimageChangeActionAction()
    }
    
    @IBAction func profileDetailsAction(_ sender: UIButton) {
        profileDetailsActionBtn()
    }
    
    @IBAction func profileEditAction(_ sender: UIButton) {
        profileeditBtn()
    }
    @IBAction func termsBtnAction(_ sender: UIButton) {
        TermsActionBtn()
    }
    
    @IBAction func privacyAction(_ sender: UIButton) {
        privacyActionBtn()
    }
    
}


