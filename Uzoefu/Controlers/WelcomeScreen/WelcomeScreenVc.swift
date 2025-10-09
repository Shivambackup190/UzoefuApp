import UIKit

class WelcomeScreenVc: UIViewController {
    
    @IBOutlet weak var homeCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var explore = ["Explore","Discover","Experience","Wishlist"]
    var discription = [
        "Uncover hidden gems and popular activities",
        "Find exciting things to do nearby",
        "Enjoy fun activities close to your current location",
        "Save your future adventures with ease"
    ]
    
    let videoNames = ["onboard", "onboard2", "onboard3", "onboard4"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeCollectionView.contentInsetAdjustmentBehavior = .never
      
        
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
        
        homeCollectionView.register(
            UINib(nibName: "WelcomeScreenCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "welcomecell"
        )
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        homeCollectionView.collectionViewLayout = layout
        homeCollectionView.showsHorizontalScrollIndicator = false
        homeCollectionView.isPagingEnabled = true
        
        pageControl.numberOfPages = discription.count
        pageControl.currentPage = 0
    }
}

// MARK: - CollectionView DataSource & Delegate
extension WelcomeScreenVc: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return discription.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "welcomecell", for: indexPath) as! WelcomeScreenCollectionViewCell
        
        cell.exploreLable.text = explore[indexPath.row]

        if cell.exploreLable.text == "Wishlist" {
            cell.skipBtnTittle.setTitle("Enter", for: .normal)
        } else {
            cell.skipBtnTittle.setTitle("Skip", for: .normal) 
        }

        
        
        let text = discription[indexPath.row]
        let words = text.split(separator: " ", maxSplits: 1)
        if let firstWord = words.first {
            let remaining = words.count > 1 ? " " + words[1] : ""
            let fullText = firstWord + remaining
            
            let attributed = NSMutableAttributedString(
                string: String(fullText),
                attributes: [.font: UIFont.systemFont(ofSize: 22, weight: .regular)]
            )
            
            attributed.addAttributes(
                [.font: UIFont.systemFont(ofSize: 25, weight: .medium)],
                range: (fullText as NSString).range(of: String(firstWord))
            )
            
            cell.descriptionLable.attributedText = attributed
        } else {
            cell.descriptionLable.text = text
        }
        
        cell.videoName = videoNames[indexPath.item]
        
        cell.skipBtnClick = {
            let nav = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            self.navigationController?.pushViewController(nav, animated: true)
        }

        
        return cell
    }
}

// MARK: - FlowLayout
extension WelcomeScreenVc: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

// MARK: - ScrollView Delegate for PageControl
extension WelcomeScreenVc {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
}
