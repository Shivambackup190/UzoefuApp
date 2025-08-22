import UIKit

class DashboardVc: UIViewController {
    
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var myscrolleview: UIScrollView!
    @IBOutlet weak var experinceActiviyvollotionView: UICollectionView!
    @IBOutlet weak var discovercollectionView: UICollectionView!
    @IBOutlet weak var exploreCollectionView: UICollectionView!
    @IBOutlet weak var experinceActiviyvollotionViewSecond: UICollectionView!
    
    @IBOutlet weak var scroolView: UIScrollView!
    
    var categoryNames = [
        "Near Me",
        "Adventure",
        "Culture",
        "Food",
        "Entertainment",
        "Family Fun",
        "Services",
        "Religion",
        "Outdoors",
        "Wildlife",
        "Wellness",
        "Historical",
        "Sport",
        "Urban",
        "Nature",
        "Tours"
        ]
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        experinceActiviyvollotionViewSecond.delegate = self
        experinceActiviyvollotionViewSecond.dataSource = self
        experinceActiviyvollotionView.delegate = self
        experinceActiviyvollotionView.dataSource = self
        discovercollectionView.delegate = self
        discovercollectionView.dataSource = self
        exploreCollectionView.delegate = self
        exploreCollectionView.dataSource = self
        
        myscrolleview.contentInsetAdjustmentBehavior = .never
        
        myImageView.layer.cornerRadius = 20
        myImageView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        myImageView.clipsToBounds = true
        
        
        let layout1 = UICollectionViewFlowLayout()
        layout1.scrollDirection = .horizontal
        experinceActiviyvollotionViewSecond.collectionViewLayout = layout1
        experinceActiviyvollotionViewSecond.showsHorizontalScrollIndicator = false
        
        let layout2 = UICollectionViewFlowLayout()
        layout2.scrollDirection = .horizontal
        experinceActiviyvollotionView.collectionViewLayout = layout2
        experinceActiviyvollotionView.showsHorizontalScrollIndicator = false
    }
    @IBAction func discoverDestinationBtnAction(_ sender: UIButton) {
        let nav = self.storyboard?.instantiateViewController(withIdentifier: "DestinationExploreVc") as! DestinationExploreVc
        
        nav.hidevalue = "ok"
        
        self.navigationController?.pushViewController(nav, animated: true)
        
    }
    
    @IBAction func AxerienceViewMoreAction(_ sender: UIButton) {
        
        let nav = self.storyboard?.instantiateViewController(withIdentifier: "DestinationExploreVc") as! DestinationExploreVc
        nav.hidevalue = "ok"
        
        self.navigationController?.pushViewController(nav, animated: true)
    }
    
    @IBAction func exporeCatagoriesActionViewMore(_ sender: UIButton) {
        let nav = self.storyboard?.instantiateViewController(withIdentifier: "ExporeCategoryVc") as! ExporeCategoryVc
        
        self.navigationController?.pushViewController(nav, animated: true)
    }
}

// MARK: - UICollectionView Delegate & DataSource
extension DashboardVc: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == discovercollectionView {
            return 9
        } else if collectionView == experinceActiviyvollotionView {
            return 5
        } else if collectionView == exploreCollectionView {
            return 7
        } else if collectionView == experinceActiviyvollotionViewSecond {
            return 4
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == discovercollectionView {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "discovercell", for: indexPath) as! discoverdestinationCell
        } else if collectionView == experinceActiviyvollotionView {
            
            return collectionView.dequeueReusableCell(withReuseIdentifier: "experiencecell", for: indexPath) as! ExperinceactivityCell
            
            
        } else if collectionView == exploreCollectionView {
            
//            return collectionView.dequeueReusableCell(withReuseIdentifier: "explorecell", for: indexPath) as! ExplreCatagoriesCell
            let cell = exploreCollectionView.dequeueReusableCell(withReuseIdentifier: "explorecell", for: indexPath) as! ExplreCatagoriesCell
            cell.categoryLable.text = categoryNames[indexPath.row]
            // check if selected here
                  let isSelected = collectionView.indexPathsForSelectedItems?.contains(indexPath) ?? false
                  cell.setSelected(isSelected)
            //newcode
            return cell
            
        } else if collectionView == experinceActiviyvollotionViewSecond {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "experiencecellSecond", for: indexPath) as! ExploreActivitySecondCell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == discovercollectionView {
            let size = (discovercollectionView.frame.width - 2) / 2
            return CGSize(width: size, height: size)
        } else if collectionView == experinceActiviyvollotionView {
            let size = (experinceActiviyvollotionView.frame.width - 2) / 2
            return CGSize(width: size, height: collectionView.bounds.height)
        } else if collectionView == exploreCollectionView {
            let size = exploreCollectionView.frame.width - 2
            return CGSize(width: size, height: size)
        } else if collectionView == experinceActiviyvollotionViewSecond {
            let size = (experinceActiviyvollotionViewSecond.frame.width - 2) / 2
            return CGSize(width: size, height: collectionView.bounds.height)
        }
        let defaultSize = (collectionView.frame.width - 2) / 2
        return CGSize(width: defaultSize, height: defaultSize)
    }
    // new code for selction
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           if let cell = collectionView.cellForItem(at: indexPath) as? ExplreCatagoriesCell {
               cell.setSelected(true)
           }
       }
    
}
