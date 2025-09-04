import UIKit

class HighlightCell: UITableViewCell, UITextViewDelegate {
    
    @IBOutlet weak var textField: UITextView!
    @IBOutlet weak var actionButton: UIButton!
    
    @IBOutlet weak var textViewHeightConstraint: NSLayoutConstraint!
    var addRemoveAction: (() -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        textField.isScrollEnabled = false
        textField.delegate = self
    }

    @IBAction func actionButtonTapped(_ sender: UIButton) {
        addRemoveAction?()
    }
    func textViewDidChange(_ textView: UITextView) {
            let size = CGSize(width: textView.frame.width, height: .infinity)
            let estimatedSize = textView.sizeThatFits(size)

            textViewHeightConstraint.constant = max(45, estimatedSize.height)

        
            if let tableView = self.parentTableView() {
                UIView.setAnimationsEnabled(false)
                tableView.beginUpdates()
                tableView.endUpdates()
                UIView.setAnimationsEnabled(true)
            }
        }
    }

  
    extension UIView {
        func parentTableView() -> UITableView? {
            var view = self.superview
            while view != nil {
                if let tableView = view as? UITableView {
                    return tableView
                }
                view = view?.superview
            }
            return nil
        }
    }
