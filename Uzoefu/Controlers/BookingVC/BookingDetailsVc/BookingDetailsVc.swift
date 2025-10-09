//
//  BookingDetailsVc.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 20/08/25.
//

import UIKit

class BookingDetailsVc: UIViewController {
    @IBOutlet weak var activityName: UILabel!
    
    @IBOutlet weak var reference: UILabel!
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var contactName: UILabel!
    
    @IBOutlet weak var number: UILabel!
    
    @IBOutlet weak var email: UILabel!
    
    @IBOutlet weak var kidsQuantity: UILabel!
    @IBOutlet weak var adultsQuantity: UILabel!
    @IBOutlet weak var address: UILabel!
    
    
    @IBOutlet weak var descripTionLbl: UILabel!
    
    @IBOutlet weak var descriptionLbl: UILabel!
    
    var bookingsdetailObj:BookingsDetailModel?
    
    @IBOutlet weak var adult_amount: UILabel!
    
    @IBOutlet weak var kids_amount: UILabel!
    
    @IBOutlet weak var subtotal: UILabel!
    
    @IBOutlet weak var countLable: UILabel!
    @IBOutlet weak var total: UILabel!
    var booking_id:Int?
    var notificationcountModelObj:NotificationCountModel?
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    override func viewWillAppear(_ animated: Bool) {
        bookingsdetailApi()
        notificationCountListApi()
    }

    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func bookforbard(_ sender: Any) {
//        let nav = self.storyboard?.instantiateViewController(withIdentifier: "BookActivityStepIstVc") as! BookActivityStepIstVc
//        self.navigationController?.pushViewController(nav, animated: true)
    }
    
    @IBAction func notificationAction(_ sender: UIButton) {
        let nav = self.storyboard?.instantiateViewController(withIdentifier: "NotificationVc") as! NotificationVc
              self.navigationController?.pushViewController(nav, animated: true)
    }
}
extension BookingDetailsVc {
    func bookingsdetailApi() {
        var param = [String:Any]()
        param = ["booking_id":booking_id ?? 0 ]
        print(param)
        BookingsDetailViewModel.bookingsdetailApi(viewController: self, parameters: param as NSDictionary) {response in
            self.bookingsdetailObj = response
            let bookingValue = self.bookingsdetailObj?.data?.booking_detail
            self.activityName.text = bookingValue?.activity_name
            self.date.text = bookingValue?.booking_date
            self.reference.text = bookingValue?.payment_id
            self.contactName.text = bookingValue?.contact_name
            self.number.text = bookingValue?.contactNumber
            self.email.text = bookingValue?.email
            self.address.text = bookingValue?.billing_address
            self.adultsQuantity.text = String(bookingValue?.adult_qty ?? 0 )
            self.kidsQuantity.text = String(bookingValue?.kids_qty ?? 0)
            
            self.adult_amount.text = bookingValue?.adult_amount
            self.kids_amount.text = bookingValue?.kids_amount
            
            self.subtotal.text = bookingValue?.subtotal
            self.total.text = bookingValue?.total
            self.descriptionLbl.text = bookingValue?.activity_name
            self.descripTionLbl.text = bookingValue?.activity_name
            
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
