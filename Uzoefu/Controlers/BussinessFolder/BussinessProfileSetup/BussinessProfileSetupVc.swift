//
//  BussinessProfileSetupVc.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 01/09/25.
//

import UIKit

class BussinessProfileSetupVc: UIViewController {
    
    @IBOutlet weak var bussnesssetUptableView: UITableView!
    var arrData = ["Company details","Contact","Operating Hours","Payment Information","Finish Set Up"]

    override func viewDidLoad() {
        super.viewDidLoad()

      
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
extension BussinessProfileSetupVc:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:  "cell") as! ProfileSetupCell
        
        cell.setUpprofileLabel.text = arrData[indexPath.row]
        
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            switch indexPath.row {
            case 0:
                let vc = storyboard?.instantiateViewController(withIdentifier: "ComapanyDetailVC") as! ComapanyDetailVC
                navigationController?.pushViewController(vc, animated: true)

               
            case 1:
                let vc = storyboard?.instantiateViewController(withIdentifier: "CompanyContactsDetailsVc") as! CompanyContactsDetailsVc
                navigationController?.pushViewController(vc, animated: true)


            case 2:
                let vc = storyboard?.instantiateViewController(withIdentifier: "OperatingHoursVc") as! OperatingHoursVc
                navigationController?.pushViewController(vc, animated: true)

                
            case 3:
                let vc = storyboard?.instantiateViewController(withIdentifier: "PaymentDetailsVc") as! PaymentDetailsVc
                navigationController?.pushViewController(vc, animated: true)

               
            case 4:
                let vc = storyboard?.instantiateViewController(withIdentifier: "SetupprofileVc") as! SetupprofileVc
                navigationController?.pushViewController(vc, animated: true)

                
            default:
                break
            }
        }
    }
    
   

