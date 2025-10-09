import UIKit

class BookActivityStepIstVc: UIViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var calenderView: UIView!
    @IBOutlet weak var DateTf: UITextField!
    
    @IBOutlet weak var icrementLable: UILabel!          // Adult count label
    @IBOutlet weak var kidsicrementLable: UILabel!      // Kids count label
    
    @IBOutlet weak var timeView: UIView!
    @IBOutlet weak var adultpriceTf: UITextField!
    @IBOutlet weak var kidspriceTf: UITextField!
    
    @IBOutlet weak var countLable: UILabel!
    @IBOutlet weak var provinceName: UILabel!
    @IBOutlet weak var activitynameLbl: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var subTotalPrice: UILabel!
    var priceCalObj:PriceCalculationModel?
    var activityTimeModelObj:ActivityTimeModel?
    var notificationcountModelObj:NotificationCountModel?
    var count: Int = 1
    var kidscount: Int = 1
    
    var childPrice: String?
    var adultPrice: String?
    var Id:Int?
    var activityname:String?
    
    var  name:String? = "shivam"
    var branchAddress:String?
    
    @IBOutlet weak var timeTextTf: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        adultpriceTf.isUserInteractionEnabled = false
        kidspriceTf.isUserInteractionEnabled = false
        //        print(Id)
//
//        branchAddress =  UserDefaults.standard.string(forKey: "branchAddress") ?? ""
//        provinceName.text = branchAddress
//        activityname = UserDefaults.standard.string(forKey: "name") ?? ""
//        activitynameLbl.text = activityname
//        
//        kidspriceTf.text = "Kids - R\(String(describing: childPrice ?? ""))"
//
//        adultpriceTf.text = "Adults - R\(String(describing: adultPrice ?? ""))"
//
//        
//        icrementLable.text = "\(count)"
//        kidsicrementLable.text = "\(kidscount)"
//        
//        calenderView.isHidden = true
//        
//        datePicker.preferredDatePickerStyle = .inline
//        datePicker.datePickerMode = .date
//        datePicker.minimumDate = Date()
//        datePicker.tintColor = .link
//        datePicker.addTarget(self, action: #selector(dateSelected), for: .valueChanged)
//        
//        
//        datePicker.date = Date()
//        dateSelected()
//        
//        calculateTotal()
//        activityTimeListApi()
//    }
        Id = UserDefaults.standard.integer(forKey: "id")  // ✅ Get id BEFORE API call
            
            branchAddress =  UserDefaults.standard.string(forKey: "branchAddress") ?? ""
            provinceName.text = branchAddress
            activityname = UserDefaults.standard.string(forKey: "name") ?? ""
            activitynameLbl.text = activityname
            
            kidspriceTf.text = "Kids - R\(String(describing: childPrice ?? ""))"
            adultpriceTf.text = "Adults - R\(String(describing: adultPrice ?? ""))"
            
            icrementLable.text = "\(count)"
            kidsicrementLable.text = "\(kidscount)"
            
            calenderView.isHidden = true
            datePicker.preferredDatePickerStyle = .inline
            datePicker.datePickerMode = .date
            datePicker.minimumDate = Date()
            datePicker.tintColor = .link
            datePicker.addTarget(self, action: #selector(dateSelected), for: .valueChanged)
            datePicker.date = Date()
            dateSelected()
            
            calculateTotal()
            
           
            activityTimeListApi()
        timeView.cornerRadius = 10
        timeView.layer.borderColor = UIColor.lightGray.cgColor
        timeView.layer.borderWidth = 1

        }
    override func viewWillAppear(_ animated: Bool) {
        notificationCountListApi()
    }
    @objc func dateSelected() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" //
        let selectedDate = dateFormatter.string(from: datePicker.date)
        DateTf.text = selectedDate
        UserDefaults.standard.set(selectedDate, forKey: "selectedDate")
    }
    
    func calculateTotal() {
        let adultPriceValue = Double(adultPrice ?? "0") ?? 0
        let childPriceValue = Double(childPrice ?? "0") ?? 0
        
        let subtotal = (adultPriceValue * Double(count)) + (childPriceValue * Double(kidscount))
        let vat = subtotal * 0.15
        let total = subtotal + vat
        
        subTotalPrice.text = String(format: "%.2f", subtotal)
        totalPrice.text = String(format: "%.2f", total)
        
        
        UserDefaults.standard.set(count, forKey: "adultcount")
        UserDefaults.standard.set(kidscount, forKey: "kidscount")
        UserDefaults.standard.set(adultPriceValue * Double(count), forKey: "adultprice")
        UserDefaults.standard.set(childPriceValue * Double(kidscount), forKey: "kidsprice")
        UserDefaults.standard.set(subtotal, forKey: "subtotal")
        UserDefaults.standard.set(total, forKey: "total")
    }
    // MARK: - Button Actions
    @IBAction func nextBtnAction(_ sender: Any) {
        priceCalulationApi()
        
    }
    
    @IBAction func dateSelectionBtn(_ sender: UIButton) {
        calenderView.isHidden = false
    }
    
    @IBAction func okBtnTapped(_ sender: UIButton) {
        dateSelected()
        calenderView.isHidden = true
    }
    
    @IBAction func cancelActionBtn(_ sender: UIButton) {
        calenderView.isHidden = true
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func notificationAction(_ sender: Any) {
        if let nav = self.storyboard?.instantiateViewController(withIdentifier: "NotificationVc") as? NotificationVc {
            self.navigationController?.pushViewController(nav, animated: true)
        }
    }
    
    //  Adult + -
    @IBAction func minusBtn(_ sender: UIButton) {
        if count > 1 {
            count -= 1
            icrementLable.text = "\(count)"
            //  Adult price update on minus
            let adultPriceValue = Double(adultPrice ?? "0") ?? 0
            adultpriceTf.text = "Adults - R\(String(format: "%.2f", adultPriceValue * Double(count)))"

            
            calculateTotal()
        }
    }
    
    @IBAction func plusBtn(_ sender: UIButton) {
        count += 1
        icrementLable.text = "\(count)"
        //  Adult price update on plus
        let adultPriceValue = Double(adultPrice ?? "0") ?? 0
        adultpriceTf.text = "Adults - R\(String(format: "%.2f", adultPriceValue * Double(count)))"

        
        calculateTotal()
    }
    
    //  Kids + -
    @IBAction func kidsMinusBtn(_ sender: UIButton) {
        if kidscount > 0 {   // ✅ allow 0 now
              kidscount -= 1
              kidsicrementLable.text = "\(kidscount)"
              
              //  Kids price update on minus
              let kidsPriceValue = Double(childPrice ?? "0") ?? 0
              if kidscount == 0 {
                  kidspriceTf.text = "Kids - R0.00"   // ✅ clear price when 0 kids
              } else {
                  kidspriceTf.text = "Kids - R\(String(format: "%.2f", kidsPriceValue * Double(kidscount)))"

              }
              
              calculateTotal()
          }
    }
    
    @IBAction func timeBtnAction(_ sender: UIButton) {
        guard let data = activityTimeModelObj?.data else { return }
           
           // 2. Prepare list of time options from API
           let times = [
               "Monday: \(data.mon_from ?? "") - \(data.mon_to ?? "")",
               "Tuesday: \(data.tue_from ?? "") - \(data.tue_to ?? "")",
               "Wednesday: \(data.wed_from ?? "") - \(data.wed_to ?? "")",
               "Thursday: \(data.thu_from ?? "") - \(data.thu_to ?? "")",
               "Friday: \(data.fri_from ?? "") - \(data.fri_to ?? "")",
               "Saturday: \(data.sat_from ?? "") - \(data.sat_to ?? "")",
               "Sunday: \(data.sun_from ?? "") - \(data.sun_to ?? "")"
           ]
           
           // 3. Create bottom popup (Action Sheet)
           let alert = UIAlertController(title: "Select Available Time", message: nil, preferredStyle: .actionSheet)
           
           // 4. Add all time options
           for time in times {
               let action = UIAlertAction(title: time, style: .default) { _ in
                   self.timeTextTf.text = time
                   UserDefaults.standard.setValue(self.timeTextTf.text, forKey: "time")
               }
               action.setValue(UIColor.gray, forKey: "titleTextColor")
               alert.addAction(action)
           }
           
           let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
           cancelAction.setValue(UIColor.systemGreen, forKey: "titleTextColor")
           alert.addAction(cancelAction)
           
          
           if let popover = alert.popoverPresentationController {
               popover.sourceView = self.view
               popover.sourceRect = CGRect(x: self.view.bounds.midX,
                                           y: self.view.bounds.midY,
                                           width: 0,
                                           height: 0)
               popover.permittedArrowDirections = []
           }
           
           // 7. Present the bottom sheet
           self.present(alert, animated: true, completion: nil)
       }
    
    
    @IBAction func kidsplusBtn(_ sender: UIButton) {
        kidscount += 1
        kidsicrementLable.text = "\(kidscount)"
        let kidsPriceValue = Double(childPrice ?? "0") ?? 0
        kidspriceTf.text = "Kids - R\(String(format: "%.2f", kidsPriceValue * Double(kidscount)))"

        calculateTotal()
        
    }
}
extension BookActivityStepIstVc {
    func priceCalulationApi() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        let selectedDate = DateTf.text?.isEmpty == false ? DateTf.text! : dateFormatter.string(from: Date())
        
        Id = UserDefaults.standard.integer(forKey: "id")
        
        
        let adultPriceValue = Double(adultPrice ?? "0") ?? 0
        let childPriceValue = Double(childPrice ?? "0") ?? 0
        let subtotal = (adultPriceValue * Double(count)) + (childPriceValue * Double(kidscount))
        
        let param: [String:Any] = [
            "activity_id": Id ?? 0,
            "date": selectedDate,
            "adultcount": count,
            "kidscount": kidscount
        ]
        print(param)
        
        PricecalculationViewModel.pricecalApiMethod(viewController: self, parameters: param as NSDictionary) { response in
            self.priceCalObj = response
            CommonMethods.showAlertMessageWithHandler(title: "", message: response?.message ?? "", view: self) {
                if let nav = self.storyboard?.instantiateViewController(withIdentifier: "BookActivityStep2ndVc") as? BookActivityStep2ndVc {
                    self.navigationController?.pushViewController(nav, animated: true)
                }
            }
        }
    }
    func activityTimeListApi() {
        let param: [String:Any] = [
            "activity_id": Id ?? 0]
          
        ActivityTimeViewModel.activityTimeApi(viewController: self, parameters: param as NSDictionary) { response in
              self.activityTimeModelObj = response
              DispatchQueue.main.async {
                  
              }
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
