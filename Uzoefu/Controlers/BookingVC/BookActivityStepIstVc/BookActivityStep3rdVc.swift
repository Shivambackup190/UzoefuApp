//
//  BookActivityStep3rdVc.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 26/08/25.

import UIKit

class BookActivityStep3rdVc: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var sections = ["Signing","Activity Description",
                    "Agreement",
                    "Waiver and Indemnity",
                    "Declaration",
                    "Acknowledgement"]
    
    var expandedSection: [Bool] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorStyle = .none
        
        tableView.register(UINib(nibName: "SiginInCell", bundle: nil), forCellReuseIdentifier: "SiginInCell")
        tableView.register(UINib(nibName: "ActivityDescriptionCell", bundle: nil), forCellReuseIdentifier: "ActivityDescriptionCell")
        tableView.register(UINib(nibName: "AgreementCell", bundle: nil), forCellReuseIdentifier: "AgreementCell")
        
        tableView.register(UINib(nibName: "WaiverandIndemnityCell", bundle: nil), forCellReuseIdentifier: "WaiverandIndemnityCell")
        
        expandedSection = Array(repeating: false, count: sections.count)
        expandedSection[0] = false
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60
    }
    
    // MARK: - Actions
    @IBAction func backActionBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func saveBtnAction(_ sender: UIButton) {
        let nav = self.storyboard?.instantiateViewController(withIdentifier: "BookActivityStep4thVc") as! BookActivityStep4thVc
        self.navigationController?.pushViewController(nav, animated: false)
    }
}

// MARK: - TableView
extension BookActivityStep3rdVc: UITableViewDelegate, UITableViewDataSource {
    
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
        let imageName = expandedSection[section] ? "minus_icon" : "plus_icon"
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "SiginInCell", for: indexPath) as! SiginInCell
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityDescriptionCell", for: indexPath) as! ActivityDescriptionCell
            cell.selectionStyle = .none
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AgreementCell", for: indexPath) as! AgreementCell
            cell.selectionStyle = .none
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "WaiverandIndemnityCell", for: indexPath) as! WaiverandIndemnityCell
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
        
        
        tableView.reloadSections(IndexSet(integer: section), with: .automatic)
    }
}
