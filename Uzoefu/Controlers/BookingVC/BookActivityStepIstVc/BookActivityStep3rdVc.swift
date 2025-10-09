//
//  BookActivityStep3rdVc.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 26/08/25.

import UIKit

class BookActivityStep3rdVc: UIViewController {
    var activityListdetailModelObj:ActivityDetailModel?
    var notificationcountModelObj:NotificationCountModel?
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var countLable: UILabel!
    
    var sections = ["Signing","Activity Description",
                    "Agreement",
                    "Waiver and Indemnity",
                    "Declaration",
                    "Acknowledgement"]
    
    var expandedSection: [Bool] = []
    var Id:Int?
    

    override func viewDidLoad() {
        super.viewDidLoad()

      
        
        Id = UserDefaults.standard.integer(forKey: "id")
      
        activityListdetailApi(category_id: Id ?? 0)
        
        tableView.separatorStyle = .none
        
        tableView.register(UINib(nibName: "SiginInCell", bundle: nil), forCellReuseIdentifier: "SiginInCell")
        tableView.register(UINib(nibName: "ActivityDescriptionCell", bundle: nil), forCellReuseIdentifier: "ActivityDescriptionCell")
        tableView.register(UINib(nibName: "AgreementCell", bundle: nil), forCellReuseIdentifier: "AgreementCell")
        
        tableView.register(UINib(nibName: "WaiverandIndemnityCell", bundle: nil), forCellReuseIdentifier: "WaiverandIndemnityCell")
        tableView.register(UINib(nibName: "DeclarationCell", bundle: nil), forCellReuseIdentifier: "DeclarationCell")
        tableView.register(UINib(nibName: "Acknowledgement", bundle: nil), forCellReuseIdentifier: "Acknowledgement")
        
        
        expandedSection = Array(repeating: false, count: sections.count)
        expandedSection[0] = false
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60
    }
    override func viewWillAppear(_ animated: Bool) {
        notificationCountListApi()
    }
    
    // MARK: - Actions
    @IBAction func backActionBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func saveBtnAction(_ sender: UIButton) {
        if let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? SiginInCell {
               
               // Save signature
               cell.saveSignature()
               
               let name = cell.clientNameTf.text ?? ""
               let contact = cell.contactNymberTf.text ?? ""
               let idNumber = cell.IdNumber.text ?? ""
               let signInDate = cell.dateSigndTf.text ?? ""
               
               // Check if signature exists
               let hasSignature = cell.hasSignature()
               
               // Alert if everything empty
               if name.isEmpty && contact.isEmpty && idNumber.isEmpty && signInDate.isEmpty && !hasSignature {
                   let alert = UIAlertController(
                       title: "Warning",
                       message: "Please fill at least one participant detail and signature.",
                       preferredStyle: .alert
                   )
                   alert.addAction(UIAlertAction(title: "OK", style: .default))
                   self.present(alert, animated: true)
                   return
               }
               
               // Append new participant
               let newParticipant = ParticipantModel(
                   clientName: name,
                   idNumber: idNumber,
                   contactNumber: contact,
                   signInDate: signInDate
               )
               cell.participants.append(newParticipant)
               print("✅ Added participant:", newParticipant)
               
               // Clear text fields & signature
               cell.clientNameTf.text = ""
               cell.contactNymberTf.text = ""
               cell.IdNumber.text = ""
               
               cell.clearSignature()
               
               // ✅ Navigate to next screen
               let nav = self.storyboard?.instantiateViewController(withIdentifier: "BookActivityStep4thVc") as! BookActivityStep4thVc
               if let activityID = activityListdetailModelObj?.data?.description?.activity_id {
                   nav.activity_idvalue = activityID
               }
               nav.participants = cell.participants  // pass all participants added so far
               self.navigationController?.pushViewController(nav, animated: true)
           }
    }
    
    @IBAction func notificationAction(_ sender: UIButton) {
        let nav = self.storyboard?.instantiateViewController(withIdentifier: "NotificationVc") as! NotificationVc
              self.navigationController?.pushViewController(nav, animated: true)
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
        headerView.tag = section  // 👈 Important for tap gesture

        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = sections[section]
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        titleLabel.textColor = UIColor(named: "#60686B")
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
        
        // 👇 Add tap gesture to the entire header view
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(headerTapped(_:)))
        headerView.addGestureRecognizer(tapGesture)
        
        return headerView
    }

    @objc func headerTapped(_ gesture: UITapGestureRecognizer) {
        if let section = gesture.view?.tag {
            toggleSectionAction(for: section)
        }
    }

    @objc func toggleSection(_ sender: UIButton) {
        toggleSectionAction(for: sender.tag)
    }

    private func toggleSectionAction(for section: Int) {
        expandedSection[section].toggle()
        tableView.reloadSections(IndexSet(integer: section), with: .automatic)
    }

    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SiginInCell", for: indexPath) as! SiginInCell
            cell.selectionStyle = .none
            cell.dateSigndTf.text = UserDefaults.standard.string(forKey: "selectedDate")
            cell.saveSignature()
            let params = cell.getParametersForAPI()
            print(params)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityDescriptionCell", for: indexPath) as! ActivityDescriptionCell
            let dict = activityListdetailModelObj?.data?.description?.description
            cell.activityDescriptionLabel.text = dict
            cell.selectionStyle = .none
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AgreementCell", for: indexPath) as! AgreementCell
            let dict = activityListdetailModelObj?.data
            cell.agrrementLable.text = dict?.indemnity?.agreement
            cell.selectionStyle = .none
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "WaiverandIndemnityCell", for: indexPath) as! WaiverandIndemnityCell
            let dict = activityListdetailModelObj?.data
            cell.waiverLabel.text = dict?.indemnity?.waiver_and_indemnity
            cell.selectionStyle = .none
            return cell
            
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DeclarationCell", for: indexPath) as! DeclarationCell
            let dict = activityListdetailModelObj?.data
            cell.declarartionLable.text = dict?.indemnity?.declaration
            cell.selectionStyle = .none
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Acknowledgement", for: indexPath) as! Acknowledgement
            let dict = activityListdetailModelObj?.data
            cell.acknowledgeLable.text = dict?.indemnity?.acknowledgement
            cell.selectionStyle = .none
            return cell
            
            
        default:
            let cell = UITableViewCell()
            cell.textLabel?.text = "Default Cell"
            cell.selectionStyle = .none
            return cell
        }
    }
    
}
extension BookActivityStep3rdVc {
    func activityListdetailApi(category_id: Int) {
        let param: [String: Any] = ["activity_id": Id as Any]
        print(param)
        
        ActivityDetailViewModel.activitydetailListApi(viewController: self, parameters: param as NSDictionary) { [self] response in
            self.activityListdetailModelObj = response
            print("Api Suceess Called")
            tableView.reloadData()
        }
    }
    func notificationCountListApi(){
          let param = [String:Any]()
          NotificationListViewModel.notificationCountListApi(viewController: self, parameters: param as NSDictionary) {  response in
              self.notificationcountModelObj = response
              self.countLable.text = "\(self.notificationcountModelObj?.data ?? 0)"

              print("Success")
          }
      }
}
