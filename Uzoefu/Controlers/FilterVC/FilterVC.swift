import UIKit

class FilterVC: UIViewController, DistanceTableViewCellDelegate {
    
    // MARK: - Outlets
    @IBOutlet weak var filterTable: UITableView!
    

    var  sections =  ["Distance","Category","Rating","Price"]
    
    var expandedSection: [Bool] = []
    var categoriesModelObj: ExploreCategoriesModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCategories()
        filterTable.separatorStyle = .none
          //  filterTable.sectionHeaderTopPadding = 0
        
        filterTable.separatorStyle = .none
        filterTable.register(UINib(nibName: "DistanceTableViewCell", bundle: nil), forCellReuseIdentifier: "DistanceTableViewCell")
        filterTable.register(UINib(nibName: "CategoriesTableViewCell", bundle: nil), forCellReuseIdentifier: "CategoriesTableViewCell")
        filterTable.register(UINib(nibName: "RatingTableViewCell", bundle: nil), forCellReuseIdentifier: "RatingTableViewCell")
        filterTable.register(UINib(nibName: "PriceTableViewCell", bundle: nil), forCellReuseIdentifier: "PriceTableViewCell")
        
        expandedSection = Array(repeating: false, count: sections.count)
        filterTable.delegate = self
        filterTable.dataSource = self
        filterTable.rowHeight = UITableView.automaticDimension
        filterTable.estimatedRowHeight = 50
        // 🔑 Footer space add karo
            let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 30))
            footerView.backgroundColor = .clear
            filterTable.tableFooterView = footerView
    }
    func fetchCategories() {
        let param = [String: Any]()
        
        ExploreCategoriesViewModel.exploreCategoriesApi(viewController: self, parameters: param as NSDictionary) { response in
            self.categoriesModelObj = response
            DispatchQueue.main.async {
                self.filterTable.reloadData()
            }
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if let sheet = self.sheetPresentationController {
            if #available(iOS 16.0, *) {
                sheet.animateChanges {
                    sheet.detents = [
                        .custom { _ in self.filterTable.contentSize.height + 100 }, // table jitna + header
                        .large()
                    ]
                }
            }
        }
    }

    
    @IBAction func dissmissAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    /// ⚡️ Table ke content ke hisaab se height calculate karega
    func preferredHeight() -> CGFloat {
        filterTable.layoutIfNeeded()
        let height = filterTable.contentSize.height
        let maxHeight = UIScreen.main.bounds.height * 0.9 // max 90% of screen
        return min(height, maxHeight)
    }

    @IBAction func applyActionBtn(_ sender: UIButton) {
    }
}

// MARK: - TableView
extension FilterVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expandedSection[section] ? 1 : 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 45))
        headerView.backgroundColor = .systemBackground
        
        let titleLabel = UILabel(frame: CGRect(x: 16, y: 0, width: tableView.frame.width - 80, height: 45))
        titleLabel.text = sections[section]
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.text = sections[section]
        titleLabel.textColor = UIColor(named: "#60686B")
        headerView.addSubview(titleLabel)
        
        let button = UIButton(type: .system)
        button.frame = CGRect(x: tableView.frame.width - 45, y: 0, width: 50, height: 45)
        let imageName = expandedSection[section] ? "minus_icon" : "plus_icon"
        button.setImage(UIImage(named: imageName), for: .normal)
        button.tintColor = .gray
        button.tag = section
        button.addTarget(self, action: #selector(toggleSection(_:)), for: .touchUpInside)
        headerView.addSubview(button)
        
        // 🔑 Gesture recognizer add karo header par
        headerView.tag = section
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(headerTapped(_:)))
        headerView.addGestureRecognizer(tapGesture)
        
        return headerView
    }
    @objc func headerTapped(_ gesture: UITapGestureRecognizer) {
        if let section = gesture.view?.tag {
            toggleSectionAction(section)
        }
        
    }
    @objc func toggleSection(_ sender: UIButton) {
        toggleSectionAction(sender.tag)
    }

    private func toggleSectionAction(_ section: Int) {
        expandedSection[section].toggle()
        filterTable.reloadSections(IndexSet(integer: section), with: .automatic)
        
        if let sheet = self.sheetPresentationController {
            if #available(iOS 16.0, *) {
                sheet.animateChanges {
                    sheet.detents = [
                        .custom { _ in self.filterTable.contentSize.height + 100 },
                        .large()
                    ]
                }
            }
        }
    }

    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1 // footer ke gap ko almost remove karne ke liye
    }
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        switch indexPath.section {
//        case 0:
//            let cell = tableView.dequeueReusableCell(withIdentifier: "DistanceTableViewCell", for: indexPath) as! DistanceTableViewCell
//            cell.selectionStyle = .none
//            cell.delegate = self
//            return cell
//            
//        case 1:
//            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoriesTableViewCell", for: indexPath) as! CategoriesTableViewCell
//            cell.selectionStyle = .none
//            return cell
//        case 2:
//            let cell = tableView.dequeueReusableCell(withIdentifier: "RatingTableViewCell", for: indexPath) as! RatingTableViewCell
//            cell.selectionStyle = .none
//            return cell
//        case 3:
//            let cell = tableView.dequeueReusableCell(withIdentifier: "PriceTableViewCell", for: indexPath) as! PriceTableViewCell
//            cell.selectionStyle = .none
//            return cell
//        default:
//            let cell = UITableViewCell()
//            cell.textLabel?.text = "Default Cell"
//            cell.selectionStyle = .none
//            return cell
//        }
//    }
//    
//
//
//}
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            switch indexPath.section {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "DistanceTableViewCell", for: indexPath) as! DistanceTableViewCell
                cell.selectionStyle = .none
                cell.delegate = self   // ✅ Delegate assigned
                return cell
                
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "CategoriesTableViewCell", for: indexPath) as! CategoriesTableViewCell
                cell.configure(with: categoriesModelObj)
                cell.selectionStyle = .none
                return cell
                
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: "RatingTableViewCell", for: indexPath) as! RatingTableViewCell
                cell.selectionStyle = .none
                return cell
                
            case 3:
                let cell = tableView.dequeueReusableCell(withIdentifier: "PriceTableViewCell", for: indexPath) as! PriceTableViewCell
                cell.selectionStyle = .none
                return cell
                
            default:
                let cell = UITableViewCell()
                cell.textLabel?.text = "Default Cell"
                cell.selectionStyle = .none
                return cell
            }
        }
        
        // Correct place for delegate method
    func showOptions(title: String, options: [String], onSelect: @escaping (String) -> Void) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
        
        // Options (e.g., 5 Km, 10 Km, etc.)
        options.forEach { option in
            let action = UIAlertAction(title: option, style: .default) { _ in
                onSelect(option)
            }
            // Set option text color (black or gray)
            action.setValue(UIColor.gray, forKey: "titleTextColor")
            alert.addAction(action)
        }
        
        // Cancel button
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        cancel.setValue(UIColor.systemGreen, forKey: "titleTextColor")  // ✅ Green cancel
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }

    }
