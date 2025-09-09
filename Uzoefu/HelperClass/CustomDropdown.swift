import UIKit

protocol CustomDropdownDelegate: AnyObject {
    func dropdown(_ dropdown: CustomDropdown, didSelectOption option: String, at index: Int)
}

class CustomDropdown: UIView, UITableViewDelegate, UITableViewDataSource {
    
    private var options: [String] = []
    private var anchorView: UIView!
    private var tableView: UITableView!
    private var isVisible = false
    private var selectedIndex: Int?
    
    weak var delegate: CustomDropdownDelegate?
    
    init(anchorView: UIView, options: [String]) {
        super.init(frame: .zero)
        self.anchorView = anchorView
        self.options = options
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = true
        tableView.layer.borderColor = UIColor.lightGray.cgColor
        tableView.layer.borderWidth = 1
        tableView.layer.cornerRadius = 8
        tableView.clipsToBounds = true
        self.addSubview(tableView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tableView.frame = self.bounds
    }
    
    func toggleDropdown(in view: UIView) {
        if isVisible {
            hideDropdown()
        } else {
            showDropdown(in: view)
        }
    }
    
    private func showDropdown(in view: UIView) {
        guard let anchorSuperview = anchorView.superview else { return }
        let anchorFrame = anchorSuperview.convert(anchorView.frame, to: view)
        
        self.frame = CGRect(x: anchorFrame.origin.x,
                            y: anchorFrame.maxY + 5,
                            width: anchorFrame.width,
                            height: 0)
        view.addSubview(self)
        
        tableView.isHidden = false
        UIView.animate(withDuration: 0.3) {
            self.frame.size.height = CGFloat(self.options.count * 44)
        }
        isVisible = true
    }
    
    private func hideDropdown() {
        UIView.animate(withDuration: 0.3, animations: {
            self.frame.size.height = 0
        }) { _ in
            self.tableView.isHidden = true
            self.removeFromSuperview()
        }
        isVisible = false
    }
    
    // MARK: - TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = options[indexPath.row]
        cell.textLabel?.textColor = (indexPath.row == selectedIndex) ? .black : .gray
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        
        // ✅ Update anchor text
        if let button = anchorView as? UIButton {
            button.setTitle(options[indexPath.row], for: .normal)
        } else if let label = anchorView as? UILabel {
            label.text = options[indexPath.row]
        } else if let textField = anchorView as? UITextField {
            textField.text = options[indexPath.row]
        }
        
        delegate?.dropdown(self, didSelectOption: options[indexPath.row], at: indexPath.row)
        hideDropdown()
        tableView.reloadData()
    }
}
