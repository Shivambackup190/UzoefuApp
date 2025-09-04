//
//  FaqViewControler.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 03/09/25.
//

import UIKit

class FaqViewControler: UIViewController {

    @IBOutlet weak var faqTableView: UITableView!
    
    @IBOutlet weak var popupBlurView: UIView!
    @IBOutlet weak var blurView: UIView!
    var sections = ["What is the cancellation policy?","Are there any medical conditions?","What happens in case of bad weather?","What equipment is provided ?"]
    
    var expandedSection: [Bool] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        //tabledata
        faqTableView.separatorStyle = .none
        faqTableView.showsHorizontalScrollIndicator = false
        faqTableView.showsVerticalScrollIndicator = false
        
        faqTableView.register(UINib(nibName: "FAQCell", bundle: nil), forCellReuseIdentifier: "FAQCell")

        
        expandedSection = Array(repeating: false, count: sections.count)
        expandedSection[0] = false
        
        faqTableView.delegate = self
        faqTableView.dataSource = self
        faqTableView.rowHeight = UITableView.automaticDimension
        faqTableView.estimatedRowHeight = 60
        blurView.isHidden = true
        popupBlurView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        popupBlurView.layer.cornerRadius = 30

    }
    
    @IBAction func addFaqAction(_ sender: Any) {
        blurView.isHidden = false
    }
    
    @IBAction func blurDismissAction(_ sender: UIButton) {
        blurView.isHidden = true
    }
    
    @IBAction func backactionBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
extension FaqViewControler: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expandedSection[section] ? 1 : 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .systemGray6
        
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = sections[section]
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        titleLabel.textColor = UIColor(hex: "#60686B")
        headerView.addSubview(titleLabel)
        
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        let imageName = expandedSection[section] ? "" : "editprofile"
        button.setImage(UIImage(named: imageName), for: .normal)
        button.tintColor = .gray
        button.tag = section
        button.addTarget(self, action: #selector(toggleSection(_:)), for: .touchUpInside)
        headerView.addSubview(button)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            
            button.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            button.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            button.widthAnchor.constraint(equalToConstant: 30),
            button.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
            
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FAQCell", for: indexPath) as! FAQCell
            cell.selectionStyle = .none
            return cell
        default:
            let cell = UITableViewCell()
            cell.textLabel?.text = "Default Cell"
            cell.selectionStyle = .none
            return cell
        }
    }
    
    
    @objc func toggleSection(_ sender: UIButton) {
        let section = sender.tag
        
        
        expandedSection[section].toggle()
        
        
        faqTableView.reloadSections(IndexSet(integer: section), with: .automatic)
    }
}
