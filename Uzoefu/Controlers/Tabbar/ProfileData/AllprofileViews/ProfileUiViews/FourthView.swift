import UIKit
class FourthView: UIView {
    var addMoreCampanyActionBtn : (()->()) = {}
    @IBOutlet weak var comapnyTable: UITableView!
    
    @IBOutlet weak var addCompanyAction: UIButton!
    
    @IBAction func addmoreaction(_ sender: Any) {
        addMoreCampanyActionBtn()
    }
}
