import UIKit

class BookActivityStep4thVc: UIViewController {
    var activityname: String?
    var paymentModelObj: PaymentModel?
    var signatureView: SignatureView!
    var activity_idvalue:Int?
    var date:String?
    var adultCount:Int?
    var adultPrice:String?
    var kidsCount:Int?
    var kidsPrice:String?
    var total:Int?
    var subtotal:String?
    var getProfileModelObj:ProfileModel?
    var fullNameTf:String?
    var firstNameTf:String?
    var sirNameTF:String?
    var mobileNumberTf:String?
    var addressTf:String?
    var usernameTf:String?
    var notificationcountModelObj:NotificationCountModel?
    var participants: [ParticipantModel] = []
    var time:String?
    var getMobile:String?
    var getaddress:String?
    var getUser:String?
   

    @IBOutlet weak var countLable: UILabel!
    @IBOutlet weak var activitynameLbl: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        print("✅ Participants received:", participants)

       
        getprofileApi()
        activityname = UserDefaults.standard.string(forKey: "name") ?? ""
        activitynameLbl.text = activityname
        
        if let savedDate = UserDefaults.standard.string(forKey: "selectedDate") {
            print("date : \(savedDate)")
            date = savedDate
        }
         adultCount = UserDefaults.standard.integer(forKey: "adultcount")
             kidsCount = UserDefaults.standard.integer(forKey: "kidscount")
        adultPrice = UserDefaults.standard.string(forKey: "adultprice")
            kidsPrice = UserDefaults.standard.string(forKey: "kidsprice")
             subtotal = UserDefaults.standard.string(forKey: "subtotal")
             total = UserDefaults.standard.integer(forKey: "total")
            let selectedDate = UserDefaults.standard.string(forKey: "selectedDate") ?? ""
        time = UserDefaults.standard.string(forKey: "time")
        getMobile = UserDefaults.standard.string(forKey: "mobile")
        getaddress = UserDefaults.standard.string(forKey: "add")
        getUser = UserDefaults.standard.string(forKey: "user")
        

    }
    override func viewWillAppear(_ animated: Bool) {
        notificationCountListApi()
    }
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }

    @IBAction func confirmBtnAction(_ sender: UIButton) {
        paymentApi()
        
    }

    @IBAction func notificationAction(_ sender: UIButton) {
        let nav = storyboard?.instantiateViewController(withIdentifier: "NotificationVc") as! NotificationVc
        navigationController?.pushViewController(nav, animated: true)
    }

    @IBAction func paynowAction(_ sender: UIButton) {
      
    }
}

extension BookActivityStep4thVc {
    
    func paymentApi() {
        guard let signaturePath = UserDefaults.standard.string(forKey: "savedSignaturePath") else {
            print(" Signature path nahi mila — saveSignature() nahi chala ya save nahi hua")
            return
        }
        let signatureURL = URL(fileURLWithPath: signaturePath)
        guard let imageData = try? Data(contentsOf: signatureURL),
              let signatureImage = UIImage(data: imageData) else {
            CommonMethods.showAlertMessage(title: "", message: "Please add signatute in sigin section", view: self)
            return
        }
        
        print(" Signature image loaded")
        
       
        // ✅ Convert arrays to comma-separated strings
               let names = participants.map { $0.clientName ?? "" }.joined(separator: ",")
               let ids = participants.map { $0.idNumber ?? "" }.joined(separator: ",")
               let contacts = participants.map { $0.contactNumber ?? "" }.joined(separator: ",")
               let dates = participants.map { $0.signInDate ?? "" }.joined(separator: ",")
          
        if participants.isEmpty {
            CommonMethods.showAlertMessage(title: "", message: "Please add at least one participant before confirming.", view: self)
            return
        }

          
          let param: [String: Any] = [
              "activity_id": activity_idvalue ?? "",
              "date": date ?? "",
              "adultcount": adultCount ?? 0,
              "kidscount": kidsCount ?? 0,
              "adultprice": adultPrice ?? "",
              "kidsprice": kidsPrice ?? "",
              "subtotal": subtotal ?? "",
              "total": total ?? "",
              "firstname": firstNameTf ?? "",
              "surname": sirNameTF ?? "",
              "username": getUser ?? "",
              "mobile_number": getMobile ?? 0,
              "billingaddress": getaddress ?? "",
              "clientname[]": names,
              "idnumber[]": ids,
              "contactnumber[]": contacts,
              "signindate[]": date ?? "",
              "times":time ?? ""]
          
          print(" Final API Params: \(param)")
        PaymentViewModel.paymentApi(
            viewController: self,
            parameters: param,
            images: [signatureImage]
        ) { response in
            self.paymentModelObj = response 
            CommonMethods.showAlertMessageWithHandler(title: "", message: self.paymentModelObj?.message ?? "", view: self) {
                let nav = self.storyboard?.instantiateViewController(withIdentifier: "BookActivityStep5thVc") as! BookActivityStep5thVc
                self.navigationController?.pushViewController(nav, animated: true)
            }
        }
    }
    func getParametersForAPI() -> [String: Any] {
        let names = participants.compactMap { $0.clientName }.filter { !$0.isEmpty }.joined(separator: ",")
        let ids = participants.compactMap { $0.idNumber }.filter { !$0.isEmpty }.joined(separator: ",")
        let contacts = participants.compactMap { $0.contactNumber }.filter { !$0.isEmpty }.joined(separator: ",")
        let dates = participants.compactMap { $0.signInDate }.filter { !$0.isEmpty }.joined(separator: ",")
        
        return [
            "clientname[]": names,
            "idnumber[]": ids,
            "contactnumber[]": contacts,
            "signindate[]": dates
        ]
    }
}
extension BookActivityStep4thVc {
    func getprofileApi() {
        let param = [String:Any]()
        
        print(param)
        
        ProfileViewModel.getProfileApi(viewController: self, parameters: param as NSDictionary) {(response) in
            self.getProfileModelObj = response
            self.fullNameTf = "\(self.getProfileModelObj?.data?.name ?? "") \(self.getProfileModelObj?.data?.lastname ?? "")"
            
            self.firstNameTf = self.getProfileModelObj?.data?.name ?? ""
            self.sirNameTF = self.getProfileModelObj?.data?.lastname ?? ""
            self.fullNameTf = "\(self.getProfileModelObj?.data?.name ?? "") \(self.getProfileModelObj?.data?.lastname ?? "")"
            
          //  self.mobileNumberTf = self.getProfileModelObj?.data?.mobile ?? ""
            self.addressTf = self.getProfileModelObj?.data?.city ?? ""
            
            self.usernameTf = self.getProfileModelObj?.data?.username ?? ""
    
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
