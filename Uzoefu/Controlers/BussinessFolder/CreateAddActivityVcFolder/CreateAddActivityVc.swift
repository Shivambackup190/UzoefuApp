//
//  CreateAddActivityVc.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 01/09/25.
//

import UIKit

class CreateAddActivityVc: UIViewController {

    @IBOutlet weak var createActivityTableView: UITableView!
    let arrData = [
        "Activity details",
        "Description",
        "Activity Hours",
        "Amenities",
        "Terms & Conditions",
        "FAQ",
        "Photos",
        "Finish Set Up"
    ]
    override func viewDidLoad() {
        super.viewDidLoad()

  
    }
    
    @IBAction func backactionBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
  
}
extension CreateAddActivityVc:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:  "cell") as! AllCreateActivtyTableViewCell
        
        cell.setUpprofileLabel.text = arrData[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            switch indexPath.row {
            case 0:
                let vc = storyboard?.instantiateViewController(withIdentifier: "AddActivityDetailVc") as! AddActivityDetailVc
                navigationController?.pushViewController(vc, animated: true)

               
            case 1:
                let vc = storyboard?.instantiateViewController(withIdentifier: "AddActivityDescripTion") as! AddActivityDescripTion
                navigationController?.pushViewController(vc, animated: true)


            case 2:
                let vc = storyboard?.instantiateViewController(withIdentifier: "AddActivityHoursVC") as! AddActivityHoursVC
                navigationController?.pushViewController(vc, animated: true)

                
            case 3:
                let vc = storyboard?.instantiateViewController(withIdentifier: "AmenitiesVC") as! AmenitiesVC
                navigationController?.pushViewController(vc, animated: true)

               
            case 4:
                let vc = storyboard?.instantiateViewController(withIdentifier: "TermsandConditionVc") as! TermsandConditionVc
                navigationController?.pushViewController(vc, animated: true)
            case 5:
                let vc = storyboard?.instantiateViewController(withIdentifier: "FaqViewControler") as! FaqViewControler
                navigationController?.pushViewController(vc, animated: true)
            case 6:
                let vc = storyboard?.instantiateViewController(withIdentifier: "AddPhotosVC") as! AddPhotosVC
                navigationController?.pushViewController(vc, animated: true)
            case 7:
                let vc = storyboard?.instantiateViewController(withIdentifier: "FinishSetUVc") as! FinishSetUVc
                navigationController?.pushViewController(vc, animated: true)

                
            default:
                break
            }
        }
    }
    
   

