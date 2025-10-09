import UIKit
import WebKit

class TermsVc: UIViewController {

    @IBOutlet weak var webkitUiviewOutlet: WKWebView!
//    var urlString = "https://mobappssolutions.in/uzoefu/termcondition"
     var urlString:String?
    var headingLbl:String?
    @IBOutlet weak var headingTextVlaue: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTermsPage()
        headingTextVlaue.text = headingLbl ?? ""
    }

    func loadTermsPage() {
        guard let url = URL(string: urlString ?? "") else {
            print(" Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        webkitUiviewOutlet.load(request)
    }
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
