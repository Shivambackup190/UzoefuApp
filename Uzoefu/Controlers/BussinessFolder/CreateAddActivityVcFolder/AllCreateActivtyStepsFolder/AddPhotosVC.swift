import UIKit
//code for collection height by content important
class AddPhotosVC: UIViewController {
    @IBOutlet weak var photosCollectionView: UICollectionView!
    @IBOutlet weak var photosCollectionViewHeight: NSLayoutConstraint!   
    @IBOutlet weak var addButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "PhotosCollectionCell", bundle: nil)
        photosCollectionView.register(nib, forCellWithReuseIdentifier: "PhotosCollectionCell")
        photosCollectionView.delegate = self
        photosCollectionView.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        photosCollectionView.collectionViewLayout = layout
        photosCollectionView.showsHorizontalScrollIndicator = false
        photosCollectionViewHeight.constant = 0
    }
    override func viewWillAppear(_ animated: Bool) {
       
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateCollectionViewHeight()
    }
    
    private func updateCollectionViewHeight() {
        self.photosCollectionView.layoutIfNeeded()
        self.photosCollectionViewHeight.constant = self.photosCollectionView.contentSize.height
    }
    
    @IBAction func backActionBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func addphotosAction(_ sender: UIButton) {
        photosCollectionViewHeight.constant = 110
    }
}

extension AddPhotosVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCollectionCell", for: indexPath) as! PhotosCollectionCell
        return cell
    }
    
    // MARK: - Flow Layout
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemsPerRow: CGFloat = 4
        let spacing: CGFloat = 5
        let sectionInsets: CGFloat = 10
        let totalSpacing = (itemsPerRow - 1) * spacing + (sectionInsets * 2)
        
        let width = (collectionView.bounds.width - totalSpacing) / itemsPerRow
        
        return CGSize(width: width, height: 110)
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
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
    }
}
