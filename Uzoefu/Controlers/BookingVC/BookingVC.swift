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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "BookingCell", bundle: nil)
        bookingTableView.register(nib, forCellReuseIdentifier: "BookingCell")
        
        bookingTableView.delegate = self
        bookingTableView.dataSource = self
        
        [activeButton, cancelledButton, pastButton].forEach {
            $0?.adjustsImageWhenHighlighted = false
        }
        
        selectButton(activeButton)
    }
    
    @IBAction func backActionBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func activeButtonAction(_ sender: UIButton) {
        selectButton(activeButton)
    }
    
    @IBAction func pastButtonAction(_ sender: UIButton) {
        selectButton(pastButton)
    }
    
    @IBAction func cancelledbtnAction(_ sender: UIButton) {
        selectButton(cancelledButton)
    }
    
    @IBAction func notificationAction(_ sender: UIButton) {
        let nav = self.storyboard?.instantiateViewController(withIdentifier: "NotificationVc") as! NotificationVc
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
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = bookingTableView.dequeueReusableCell(withIdentifier: "BookingCell", for: indexPath) as! BookingCell
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nav = self.storyboard?.instantiateViewController(withIdentifier: "BookingDetailsVc") as! BookingDetailsVc
        self.navigationController?.pushViewController(nav, animated: true)
    }
    
    
}


