//
//  BusinessCompanyDetailsVc.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 04/09/25.
//

import UIKit

class BusinessCompanyDetailsVc: UIViewController {

    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var overviewButton: UIButton!
    
    @IBOutlet weak var overViewLable: UILabel!
    
    @IBOutlet weak var overViewcolor: UIView!
    @IBOutlet weak var profileButton: UIButton!
    
    @IBOutlet weak var profileColor: UIView!
    
    @IBOutlet weak var profileLabel: UILabel!
    
    @IBOutlet weak var activityButton: UIButton!
    
    @IBOutlet weak var activityView: UIView!
    
    
    @IBOutlet weak var activityLabel: UILabel!
    
    @IBOutlet weak var bookingButton: UIButton!
    
    @IBOutlet weak var bookingView: UIView!
    
    @IBOutlet weak var bookingLable: UILabel!
    
    
    
    var currentIndex = 0
    private var currentView: UIView?
    var firstView:BussinessOverViewClass!
    var secondView:BussniessProfileClass!
    var thirdView:BussniessActivitiesClass!
    var fourthView:BussninessBookingClass!
    var loadNib = [UIView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        firstView = (Bundle.main.loadNibNamed("BussinessOverViewClass", owner: self, options: nil)![0] as! BussinessOverViewClass)
       secondView = (Bundle.main.loadNibNamed("BussniessProfileClass", owner: self, options: nil)![0] as! BussniessProfileClass)
        thirdView = (Bundle.main.loadNibNamed("BussniessActivitiesClass", owner: self, options: nil)![0] as! BussniessActivitiesClass)
        fourthView = (Bundle.main.loadNibNamed("BussninessBookingClass", owner: self, options: nil)![0] as! BussninessBookingClass)
        
        
        loadNib.append(firstView)
      loadNib.append(secondView)
        loadNib.append(thirdView)
        loadNib.append(fourthView)
        // tableViewLoadByNib
        loadactivtyCell()
        loadBookingCell()
        addMoreActionBtn()
        
        for i in loadNib {
            i.frame = containerView.bounds
            containerView.addSubview(i)
            
        }
        containerView.clipsToBounds = true
        containerView.bringSubviewToFront(loadNib[0])
    }
    func changeTab(index: Int) {
        guard index != currentIndex else { return }
        
        let oldView = loadNib[currentIndex]
        let newView = loadNib[index]
        let direction: CGFloat = index > currentIndex ? 1 : -1
        let width = containerView.bounds.width
        
        newView.frame = containerView.bounds.offsetBy(dx: direction * width, dy: 0)
        containerView.addSubview(newView)
        
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut], animations: {
            oldView.frame = self.containerView.bounds.offsetBy(dx: -direction * width, dy: 0)
            newView.frame = self.containerView.bounds
        }, completion: { _ in
            oldView.removeFromSuperview()
        })
        
        resetAllTabs()
        switch index {
        case 0: selectTab(colorView: overViewcolor, label: overViewLable)
        case 1: selectTab(colorView: profileColor, label: profileLabel)
        case 2: selectTab(colorView: activityView, label: activityLabel)
        case 3: selectTab(colorView: bookingView, label: bookingLable)
        default: break
        }
        
        currentIndex = index
    }
    
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func resetAllTabs() {
        let defaultColor = #colorLiteral(red: 0.4512393475, green: 0.4832214117, blue: 0.4951165318, alpha: 1)
        let defaultText = #colorLiteral(red: 0.4512393475, green: 0.4832214117, blue: 0.4951165318, alpha: 1)
        overViewcolor.isHidden = true
        profileColor.isHidden = true
        activityView.isHidden = true
        bookingView.isHidden = true
        
        overViewcolor.backgroundColor = defaultColor
        profileColor.backgroundColor = defaultColor
        activityView.backgroundColor = defaultColor
        bookingView.backgroundColor = defaultColor
        
        overViewLable.textColor = defaultText
        profileLabel.textColor = defaultText
        activityLabel.textColor = defaultText
        bookingLable.textColor = defaultText
    }
    func selectTab(colorView: UIView, label: UILabel) {
        let selectedColor = #colorLiteral(red: 0.1960784314, green: 0.8039215686, blue: 0.03807460484, alpha: 1)
        
        colorView.isHidden = false
        colorView.backgroundColor = selectedColor
        label.textColor = selectedColor
    }
    // MARK: - Button Actions
    
    @IBAction func overviewBtnAction(_ sender: UIButton) {
        changeTab(index: 0)
    }
    
    @IBAction func profileBtnAction(_ sender: UIButton) {
//        changeTab(index: 1)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "BussinessProfileSetupVc") as! BussinessProfileSetupVc
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func activityBtnAction(_ sender: UIButton) {
        changeTab(index: 2)
    }
   
    @IBAction func bookingBtnAction(_ sender: UIButton) {
        changeTab(index: 3)
    }
    func loadactivtyCell() {
        let nib = UINib(nibName: "ActivityTableCell", bundle: nil)
        thirdView.BussnessActivityTableView.register(nib, forCellReuseIdentifier: "ActivityTableCell")
        
        thirdView.BussnessActivityTableView.delegate = self
        thirdView.BussnessActivityTableView.dataSource = self
      
    }
    func loadBookingCell() {
        let nib = UINib(nibName: "BussnessBookinghistoryCell", bundle: nil)
        fourthView.bookingTable.register(nib, forCellReuseIdentifier: "BussnessBookinghistoryCell")
        
        fourthView.bookingTable.delegate = self
        fourthView.bookingTable.dataSource = self
      
    }
    func addMoreActionBtn() {
        thirdView.AddmoreActionBtn = {
            let nav = self.storyboard?.instantiateViewController(withIdentifier: "CreateAddActivityVc") as! CreateAddActivityVc
            
            self.navigationController?.pushViewController(nav, animated: true)
        }
    }
}
extension BusinessCompanyDetailsVc:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == thirdView.BussnessActivityTableView {
            return 10
        }
        else {
            return 5
        }
      
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView ==   thirdView.BussnessActivityTableView {
            let cell = thirdView.BussnessActivityTableView.dequeueReusableCell(withIdentifier: "ActivityTableCell", for: indexPath) as! ActivityTableCell
            cell.selectionStyle = .none
            return cell
        }
        else {
            let cell = fourthView.bookingTable.dequeueReusableCell(withIdentifier: "BussnessBookinghistoryCell", for: indexPath) as! BussnessBookinghistoryCell
            cell.selectionStyle = .none
            return cell
            
        }
     
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        let nav = self.storyboard?.instantiateViewController(identifier: "CompanyDetailsVC") as! CompanyDetailsVC
        //        self.navigationController?.pushViewController(nav, animated: true)
    }
    
    
}
