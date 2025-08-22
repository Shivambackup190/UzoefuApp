import UIKit

class WelcomeScreenVc: UIViewController {
    @IBOutlet weak var homeCollectionView: UICollectionView!
    
    var explore = ["Explore","Discover","Experience","Wishlist"]
    var discription = [
        "Uncover hidden gems and popular activities",
        "Find exciting things to do nearby",
        "Enjoy fun activities close to your current location",
        "Save your future adventures with ease"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
        
        homeCollectionView.register(UINib(nibName: "WelcomeScreenCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "welcomecell")
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        homeCollectionView.collectionViewLayout = layout
        homeCollectionView.showsHorizontalScrollIndicator = false
    }
}

extension WelcomeScreenVc: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return discription.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "welcomecell", for: indexPath) as! WelcomeScreenCollectionViewCell
        cell.exploreLable.text = explore[indexPath.row]
        
       
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
        
        let videoNames = ["onboard", "onboard2", "onboard3", "onboard4"]
        cell.videoName = videoNames[indexPath.item]
        
        cell.skipBtnClick = {
            let nextPageIndex = indexPath.item + 1
            
            if indexPath.item == 3 {
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let sceneDelegate = windowScene.delegate as? SceneDelegate {
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let tabBarVC = storyboard.instantiateViewController(withIdentifier: "LoginVC")
                    
                    sceneDelegate.window?.rootViewController = tabBarVC
                    sceneDelegate.window?.makeKeyAndVisible()
                }
            } else {
                let newIndexPath = IndexPath(item: nextPageIndex, section: 0)
                self.homeCollectionView.scrollToItem(at: newIndexPath, at: .centeredHorizontally, animated: true)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                    if let visibleCell = self.homeCollectionView.visibleCells.first as? WelcomeScreenCollectionViewCell {
                        visibleCell.configurePageControl(currentPage: nextPageIndex, totalPages: 4)
                    }
                }
            }
        }
        
        return cell
    }
}

extension WelcomeScreenVc: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
