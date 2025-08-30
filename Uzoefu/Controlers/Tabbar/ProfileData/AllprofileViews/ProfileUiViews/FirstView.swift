import UIKit

class FirstView: UIView {
    var BookingAction : (()->()) = {}
    var WishListAction : (()->()) = {}
    @IBAction func bookingActionButton(_ sender: Any) {
        BookingAction()
    }
    
    @IBAction func wishListAction(_ sender: UIButton) {
        WishListAction()
    }
}


