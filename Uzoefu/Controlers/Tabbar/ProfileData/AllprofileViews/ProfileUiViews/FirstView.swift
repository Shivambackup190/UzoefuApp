import UIKit

class FirstView: UIView {
    var BookingAction : (()->()) = {}
    var WishListAction : (()->()) = {}
    
    var logOutActionAction : (()->()) = {}
    var profileimageChangeActionAction : (()->()) = {}
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var profileImageOutLet: UIImageView!
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
}


