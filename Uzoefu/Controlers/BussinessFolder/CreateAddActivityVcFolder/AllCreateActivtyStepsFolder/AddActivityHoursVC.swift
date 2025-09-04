//
//  AddActivityHoursVC.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 02/09/25.
//


import UIKit


class AddActivityHoursVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sameSwitch: UISwitch!
    
    let days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    var isSameHours = false
    
    var startTimes: [String] = Array(repeating: "09:10", count: 7)
    var endTimes: [String] = Array(repeating: "11:20", count: 7)
    
    var selectedDays: [Bool] = Array(repeating: false, count: 7)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        sameSwitch.addTarget(self, action: #selector(sameSwitchChanged), for: .valueChanged)
    }
    
    @objc func sameSwitchChanged(_ sender: UISwitch) {
        isSameHours = sender.isOn
        tableView.reloadData()
    }
    @IBAction func backActionBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}


extension AddActivityHoursVC: UITableViewDelegate, UITableViewDataSource, OperatingHoursCellDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
               return 7
           } else {
               return 1
           }
    }
    //  return section == 0 ? days.count : 1
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddactivityHourCell", for: indexPath) as! AddactivityHourCell
        cell.delegate = self
        
        if indexPath.section == 0 {
            cell.dayLabel.text = days[indexPath.row]
            cell.startTimeField.text = startTimes[indexPath.row]
            cell.endTimeField.text = endTimes[indexPath.row]
            cell.updateButton(isSelected: selectedDays[indexPath.row])
        } else {
           // cell.dayLabel.text = "Public Holiday"
//            cell.startTimeField.text = "10:05"
//            cell.endTimeField.text = "11:10"
//            cell.updateButton(isSelected: false)
        }
        cell.selectionStyle = .none
        return cell
    }
    func didTapSelectButton(in cell: AddactivityHourCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            selectedDays[indexPath.row].toggle()
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return nil
        } else {
            return "Public Holidays"
        }
    }

    
}


