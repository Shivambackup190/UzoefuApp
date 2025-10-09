//
//  NotificationVc.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 11/09/25.
import UIKit

class NotificationVc: UIViewController {
    
    @IBOutlet weak var notificationTableView: UITableView!
  
    
    @IBOutlet weak var clearAllBtn: UIButton!
    @IBOutlet weak var ReadNotificationText: UILabel!
    
    @IBOutlet weak var notificationPopUpView: UIView!
    var notificationModelObj:NotificationListModel?
    var notificationcountModelObj:NotificationCountModel?
    var notiticationseenObj:NotificationSeenModel?
    var notificationDeleteObj:NotificationDeleteModel?
    var notificationId:Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        notificationPopUpView.isHidden = true
        
        notificationListApi()
        let nib = UINib(nibName: "NotificationtableviewCell", bundle: nil)
        notificationTableView.register(nib, forCellReuseIdentifier: "NotificationtableviewCell")
        
        notificationTableView.delegate = self
        notificationTableView.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        notificationListApi()
    }
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func crossBtn(_ sender: UIButton) {
        notificationPopUpView.isHidden = true
    }
    
    @IBAction func clearAllBtnAction(_ sender: UIButton) {
          let alert = UIAlertController(title: "Confirm Delete All",
                                         message: "Are you sure you want to clear all notifications?",
                                         preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Clear All", style: .destructive, handler: { _ in
            self.notificationDeleteListApi(notification_id: nil) // nil → all delete
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
    
extension NotificationVc: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notificationModelObj?.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = notificationTableView.dequeueReusableCell(withIdentifier: "NotificationtableviewCell", for: indexPath) as! NotificationtableviewCell
        
        
        if let notification = notificationModelObj?.data?[indexPath.row] {
            let combinedText = "\(notification.title ?? ""): \(notification.message ?? "")"
            cell.notifivationtittle.text = combinedText
            if notification.is_seen == 1 {
                cell.seenBtn.isHidden = true
            }
            else {
                cell.seenBtn.isHidden = false
            }
        }
        cell.durationLable.text = notificationModelObj?.data?[indexPath.row].time_ago
        notificationId = notificationModelObj?.data?[indexPath.row].id
        cell.deleteBtn = { [weak self] in
            guard let self = self else { return }
            
            let alert = UIAlertController(title: "Confirm Delete",
                                          message: "Are you sure you want to delete this notification?",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
                if let id = self.notificationModelObj?.data?[indexPath.row].id {
                    self.deleteSingleNotification(at: indexPath, notificationId: id)
                }
            }))
            self.present(alert, animated: true, completion: nil)
        }



        
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        notificationPopUpView.isHidden = false
        guard let notification = notificationModelObj?.data?[indexPath.row] else { return }
        
        let combinedText = "\(notification.title ?? ""): \(notification.message ?? "")"
        self.ReadNotificationText.text = combinedText
        
      
        
        notificationReadApi(notificationId: notification.id)
    }
    
    
}
extension NotificationVc {
    func notificationListApi() {
        let param = [String:Any]()
        NotificationListViewModel.notificationListApi(viewController: self, parameters: param as NSDictionary) { response in
            self.notificationModelObj = response
            self.notificationTableView.reloadData()
            if (self.notificationModelObj?.data?.isEmpty ?? true) {
                self.clearAllBtn.isHidden = true
            } else {
                self.clearAllBtn.isHidden = false
            }
        }
    }

    
    func notificationCountListApi() {
        let param = [String:Any]()
        NotificationListViewModel.notificationCountListApi(viewController: self, parameters: param as NSDictionary) { response in
            self.notificationcountModelObj = response
        }
    }
    
    func notificationReadApi(notificationId: Int?) {
        guard let id = notificationId else { return }
        let param: [String: Any] = ["notification_id": id]
        NotificationListViewModel.notificationSeenApi(viewController: self, parameters: param as NSDictionary) { response in
            self.notiticationseenObj = response
            print("Notification marked as read: \(response?.message ?? "")")
            
            
            self.notificationCountListApi()
            self.notificationListApi()
        }
    }
    func notificationDeleteListApi(notification_id: Int?) {
        var param: [String: Any] = [:]
        if let id = notification_id {
            param["notification_id"] = id
        }
        
        NotificationListViewModel.notificationDeleteApi(viewController: self, parameters: param as NSDictionary) { response in
            self.notificationDeleteObj = response
            print("Notification deleted: \(response?.message ?? "")")
            
            self.notificationListApi()   // reload for all clear
            self.notificationCountListApi()
        }
    }

    func deleteSingleNotification(at indexPath: IndexPath, notificationId: Int) {
        var param: [String: Any] = ["notification_id": notificationId]
        
        NotificationListViewModel.notificationDeleteApi(viewController: self, parameters: param as NSDictionary) { response in
            self.notificationDeleteObj = response
            print("Notification deleted: \(response?.message ?? "")")
            
        
            self.notificationModelObj?.data?.remove(at: indexPath.row)
            
           
            self.notificationTableView.beginUpdates()
            self.notificationTableView.deleteRows(at: [indexPath], with: .fade)
            self.notificationTableView.endUpdates()
            
            // Count update ke liye
            self.notificationCountListApi()
        }
    }

}
