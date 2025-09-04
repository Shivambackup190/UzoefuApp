import UIKit

class AmenitiesVC: UIViewController {

    @IBOutlet weak var Mypagecontroller: UIPageControl!
    @IBOutlet weak var ametiCollectionView: UICollectionView!
    let amenities = [
        "Accessibility",
        "Baths",
        "Beauty Salon",
        "Bike Paths",
        "Beach",
        "Braai Area",
        "Childcare",
        "Clean Air",
        "Clinic",
        "Club House",
        "Community Centre",
        "Eatery Spa",
        "Fitness Centre",
        "Gardens",
        "Gym",
        "Hair Salon",
        "Jogging Track",
        "Karaoke",
        "Library",
        "Office Services",
        "Parking",
        "Pet Facilities",
        "Picnic Area",
        "Play Area",
        "Pleasant Views",
        "Poolside Bar",
        "Printing",
        "Sheltered Parking",
        "Shuttle Services",
        "Sports Equipment",
        "Swimming Pool",
        "Wifi"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
       
        let nib = UINib(nibName: "AmenitiesCollectoinCell", bundle: nil)
        ametiCollectionView.register(nib, forCellWithReuseIdentifier: "Cell")
        
        ametiCollectionView.delegate = self
        ametiCollectionView.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        ametiCollectionView.collectionViewLayout = layout
        ametiCollectionView.showsHorizontalScrollIndicator = false
        ametiCollectionView.isPagingEnabled = true
        let itemsPerPage = 8
            let pageCount = Int(ceil(Double(amenities.count) / Double(itemsPerPage)))
            Mypagecontroller.numberOfPages = pageCount
            Mypagecontroller.currentPage = 0
        
    }
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
extension AmenitiesVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return amenities.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! AmenitiesCollectoinCell
        cell.titleLabel.text = amenities[indexPath.row]
        return cell
    }
    
    // MARK: - Flow Layout
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemsPerRow: CGFloat = 2
        let spacing: CGFloat = 5
        let sectionInsets: CGFloat = 10
        let totalSpacing = (itemsPerRow - 1) * spacing + (sectionInsets * 2)
        
        let width = (collectionView.bounds.width - totalSpacing) / itemsPerRow
        
        return CGSize(width: width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    //this code for hozirnol otherwise can skip
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? AmenitiesCollectoinCell {
            cell.isChecked.toggle()
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
           let page = Int(round(scrollView.contentOffset.x / scrollView.frame.size.width))
           Mypagecontroller.currentPage = page
       }
    
}
    

