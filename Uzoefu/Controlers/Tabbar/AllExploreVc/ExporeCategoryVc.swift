//
//  ExporeCategoryVc.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 12/08/25.
//

import UIKit

class ExporeCategoryVc: UIViewController {
    
    @IBOutlet weak var countLable: UILabel!
    @IBOutlet weak var exporeCatagoriesCollection: UICollectionView!
    var categoriesModelObj:ExploreCategoriesModel?
    var didselctletCategoryId :Int?
    var notificationcountModelObj:NotificationCountModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        exporeCatagoriesCollection.delegate = self
        exporeCatagoriesCollection.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        exporeCatagoriesCollection.collectionViewLayout = layout
        
    }
    override func viewWillAppear(_ animated: Bool) {
        exploreCategoriesApi()
        notificationCountListApi()
    }
    @IBAction func backActionBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func menuBtnAction(_ sender: UIButton) {
        let nav = self.storyboard?.instantiateViewController(withIdentifier: "SettingsVC") as! SettingsVC
        self.navigationController?.pushViewController(nav, animated: true)
    }
}
extension ExporeCategoryVc: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoriesModelObj?.data?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ExporeCategoryCollectionViewCell
        cell.categoryLable.text = categoriesModelObj?.data?[indexPath.row].name
        cell.countLable.text = "(\(categoriesModelObj?.data?[indexPath.row].activitiesCount ?? 0))"
        
        
        
        if let icon = categoriesModelObj?.data?[indexPath.row].icon {
           
            let cleanedIcon = icon.replacingOccurrences(of: "\\/", with: "/")
            let fullURLString = image_Url + cleanedIcon
            
            if let url = URL(string: fullURLString) {
                cell.iconImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
            } else {
                cell.iconImageView.image = UIImage(named: "placeholder")
            }
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemsPerRow: CGFloat = 2
        let spacing: CGFloat = 5
        let sectionInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        let totalSpacing = sectionInsets.left + sectionInsets.right + (spacing * (itemsPerRow - 1))
        let availableWidth = collectionView.frame.width - totalSpacing
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
     let  didselctletCategoryIds = categoriesModelObj?.data?[indexPath.row].id
        let nav = self.storyboard?.instantiateViewController(withIdentifier: "SearcResultExplorVc") as! SearcResultExplorVc
        
        nav.myvalue = "\(String(describing: categoriesModelObj?.data?[indexPath.row].name ?? "")) (\(String(describing: categoriesModelObj?.data?[indexPath.row].activitiesCount ?? 0)))"
        nav.didselctletCategoryId = didselctletCategoryIds
        nav.myvalueapicall = "apicall"
        self.navigationController?.pushViewController(nav, animated: true)

     
    }
}
extension ExporeCategoryVc {
   func exploreCategoriesApi() {
       let param = [String:Any]()
          
           print(param)
           
           ExploreCategoriesViewModel.exploreCategoriesApi(viewController: self, parameters: param as NSDictionary) {(response) in
               self.categoriesModelObj = response
               print("jai hind")
               self.exporeCatagoriesCollection.reloadData()
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
