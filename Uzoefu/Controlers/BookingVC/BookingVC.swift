//
//  BookingVC.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 20/08/25.

import UIKit

class BookingVC: UIViewController {
    
    @IBOutlet weak var bookingTableView: UITableView!
    @IBOutlet weak var activeButton: UIButton!
    @IBOutlet weak var cancelledButton: UIButton!
    @IBOutlet weak var pastButton: UIButton!
    var bookingListObj:bookingListModel?
    var notificationcountModelObj:NotificationCountModel?
    @IBOutlet weak var countLable: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let nib = UINib(nibName: "BookingCell", bundle: nil)
        bookingTableView.register(nib, forCellReuseIdentifier: "BookingCell")
        
        bookingTableView.delegate = self
        bookingTableView.dataSource = self
        
        [activeButton, cancelledButton, pastButton].forEach {
            $0?.adjustsImageWhenHighlighted = false
        }
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        selectButton(activeButton)
        bookingListApi(status: "active")
        notificationCountListApi()
    }
    
    @IBAction func backActionBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func activeButtonAction(_ sender: UIButton) {
        selectButton(activeButton)
        bookingListApi(status: "active")
    }
    
    @IBAction func pastButtonAction(_ sender: UIButton) {
        selectButton(pastButton)
        bookingListApi(status: "completed")
    }
    
    @IBAction func cancelledbtnAction(_ sender: UIButton) {
        selectButton(cancelledButton)
        bookingListApi(status: "cancelled")
    }
    
    @IBAction func notificationAction(_ sender: UIButton) {
        let nav = self.storyboard?.instantiateViewController(withIdentifier: "NotificationVc") as! NotificationVc
              self.navigationController?.pushViewController(nav, animated: true)
    }
    
    @IBAction func menuBtnAction(_ sender: UIButton) {
        let nav = self.storyboard?.instantiateViewController(withIdentifier: "SettingsVC") as! SettingsVC
              self.navigationController?.pushViewController(nav, animated: true)
    }
    
    // MARK: - Button Selection
    
    func selectButton(_ selectedButton: UIButton) {
        
        let allButtons = [activeButton, pastButton, cancelledButton]
        allButtons.forEach {
            removeBottomBorder(from: $0)
            $0?.setTitleColor(.gray, for: .normal)
        }
        addBottomBorder(to: selectedButton, color: .green, height: 2)
        selectedButton.setTitleColor(.green, for: .normal)
    }
    
    func addBottomBorder(to view: UIView, color: UIColor, height: CGFloat) {
        removeBottomBorder(from: view)
        
        let border = CALayer()
        border.name = "bottomBorder"
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0,
                              y: view.frame.height - height,
                              width: view.frame.width,
                              height: height)
        view.layer.addSublayer(border)
    }
    
    func removeBottomBorder(from view: UIView?) {
        view?.layer.sublayers?.removeAll(where: { $0.name == "bottomBorder" })
    }
}

extension BookingVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookingListObj?.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = bookingTableView.dequeueReusableCell(withIdentifier: "BookingCell", for: indexPath) as! BookingCell
        cell.selectionStyle = .none
        let bookingDict = bookingListObj?.data?[indexPath.row]
        
        cell.activityName.text = bookingDict?.activity_name
        cell.dateLbl.text = bookingDict?.date
        cell.priceLbl.text = bookingDict?.total
        cell.activeLabel.text = bookingDict?.activity_status
        cell.reebookBtnAction = {
            let categoryId = bookingDict?.activity_id ?? 0
            let nav = self.storyboard?.instantiateViewController(withIdentifier: "ActivityScreenVC") as! ActivityScreenVC
            nav.didselctletCategoryId = categoryId
            self.navigationController?.pushViewController(nav, animated: true)
        }
        
        if let icon = bookingDict?.images {
            let cleanedIcon = icon.replacingOccurrences(of: "\\/", with: "/")
            let fullURLString = imagePathUrl + cleanedIcon
            if let url = URL(string: fullURLString) {
                cell.bookingImg.sd_setImage(with: url, placeholderImage: UIImage(named: "wishListImg"))
            } else {
                cell.bookingImg.image = UIImage(named: "wishListImg")
            }
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nav = self.storyboard?.instantiateViewController(withIdentifier: "BookingDetailsVc") as! BookingDetailsVc
        nav.booking_id = bookingListObj?.data?[indexPath.row].id
        self.navigationController?.pushViewController(nav, animated: true)
    }
    
    
}
extension BookingVC {
    func bookingListApi(status: Any) {
            let param: [String: Any] = [
                "status": status
            ]
        
        BookingListViewModel.bookingListApi(viewController: self, parameters: param as NSDictionary) {(response) in
            self.bookingListObj = response
            print("jai hind")
            self.bookingTableView.reloadData()
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

