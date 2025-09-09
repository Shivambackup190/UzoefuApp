import UIKit

class FirstView: UIView {
    var BookingAction : (()->()) = {}
    var WishListAction : (()->()) = {}
    
    var logOutActionAction : (()->()) = {}
    @IBAction func bookingActionButton(_ sender: Any) {
        BookingAction()
    }
    
    @IBAction func wishListAction(_ sender: UIButton) {
        WishListAction()
    }
    
    
    @IBAction func logoutAction(_ sender: Any) {
        logOutActionAction()
    }
}


