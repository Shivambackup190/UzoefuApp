import UIKit

class ProfileVc: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var overviewButton: UIButton!
    
    @IBOutlet weak var overViewLable: UILabel!
    
    @IBOutlet weak var overViewcolor: UIView!
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var rewardsButton: UIButton!
    @IBOutlet weak var companiesButton: UIButton!
    
    @IBOutlet weak var profileColor: UIView!
    
    
    @IBOutlet weak var companiesLabel: UILabel!
    @IBOutlet weak var rewardsColor: UIView!
    
    @IBOutlet weak var profileLabel: UILabel!
    
    @IBOutlet weak var rewardsLabel: UILabel!
    
    
    @IBOutlet weak var companiesColor: UIView!
    
    var currentIndex = 0
    private var currentView: UIView?
    var firstView:FirstView!
    var secondView:SecondView!
    var thirdView:ThirdView!
    var fourthView:FourthView!
    var loadNib = [UIView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstView = (Bundle.main.loadNibNamed("FirstView", owner: self, options: nil)![0] as! FirstView)
        secondView = (Bundle.main.loadNibNamed("SecondView", owner: self, options: nil)![0] as! SecondView)
        thirdView = (Bundle.main.loadNibNamed("ThirdView", owner: self, options: nil)![0] as! ThirdView)
        fourthView = (Bundle.main.loadNibNamed("FourthView", owner: self, options: nil)![0] as! FourthView)
        
        
        loadNib.append(firstView)
        loadNib.append(secondView)
        loadNib.append(thirdView)
        loadNib.append(fourthView)
        
        for i in loadNib {
            i.frame = containerView.bounds
            containerView.addSubview(i)
            
        }
        containerView.clipsToBounds = true
        containerView.bringSubviewToFront(loadNib[0])
        
        
        loadfouthViewCell()
        
        selectFavourteNib()
        
        bookingBtnAction()
        
        wishlistBtnAction()
        plusCompannyActionBtn()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeLeft.direction = .left
        containerView.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeRight.direction = .right
        containerView.addGestureRecognizer(swipeRight)
        
    }
    @objc func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .left {
            if currentIndex < loadNib.count - 1 {
                changeTab(index: currentIndex + 1)
            }
        } else if gesture.direction == .right {
            if currentIndex > 0 {
                changeTab(index: currentIndex - 1)
            }
        }
    }
    
    func changeTab(index: Int) {
        guard index != currentIndex else { return }
        
        let oldView = loadNib[currentIndex]
        let newView = loadNib[index]
        let direction: CGFloat = index > currentIndex ? 1 : -1
        let width = containerView.bounds.width
        
        newView.frame = containerView.bounds.offsetBy(dx: direction * width, dy: 0)
        containerView.addSubview(newView)
        
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut], animations: {
            oldView.frame = self.containerView.bounds.offsetBy(dx: -direction * width, dy: 0)
            newView.frame = self.containerView.bounds
        }, completion: { _ in
            oldView.removeFromSuperview()
        })
        
        resetAllTabs()
        switch index {
        case 0: selectTab(colorView: overViewcolor, label: overViewLable)
        case 1: selectTab(colorView: profileColor, label: profileLabel)
        case 2: selectTab(colorView: rewardsColor, label: rewardsLabel)
        case 3: selectTab(colorView: companiesColor, label: companiesLabel)
        default: break
        }
        
        currentIndex = index
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    // MARK: - Button Actions
    @IBAction func overViewBtnAction(_ sender: UIButton) {
        changeTab(index: 0)
    }
    
    @IBAction func profileBtnAction(_ sender: UIButton) {
        changeTab(index: 1)
    }
    
    @IBAction func rewardBtnAction(_ sender: UIButton) {
        changeTab(index: 2)
    }
    
    @IBAction func companiesBtnAction(_ sender: UIButton) {
        changeTab(index: 3)
    }
    
    func loadfouthViewCell() {
        let nib = UINib(nibName: "CompanyTableCell", bundle: nil)
        fourthView.comapnyTable.register(nib, forCellReuseIdentifier: "CompanyTableCell")
        
        fourthView.comapnyTable.delegate = self
        fourthView.comapnyTable.dataSource = self
        fourthView.comapnyTable.allowsSelection = true
    }
    func selectFavourteNib() {
        let nibb = UINib(nibName: "SelectFavouriteActivityCell", bundle: nil)
        secondView.selectFoavariteCollection.register(nibb, forCellWithReuseIdentifier: "SelectFavouriteActivityCell")
        
        secondView.selectFoavariteCollection.delegate = self
        secondView.selectFoavariteCollection.dataSource = self
    }
    
}
extension ProfileVc:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = fourthView.comapnyTable.dequeueReusableCell(withIdentifier: "CompanyTableCell", for: indexPath) as! CompanyTableCell
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nav = self.storyboard?.instantiateViewController(identifier: "CompanyDetailsVC") as! CompanyDetailsVC
        self.navigationController?.pushViewController(nav, animated: true)
    }
    func resetAllTabs() {
        let defaultColor = #colorLiteral(red: 0.4512393475, green: 0.4832214117, blue: 0.4951165318, alpha: 1)
        let defaultText = #colorLiteral(red: 0.4512393475, green: 0.4832214117, blue: 0.4951165318, alpha: 1)
        overViewcolor.isHidden = true
        profileColor.isHidden = true
        rewardsColor.isHidden = true
        companiesColor.isHidden = true
        
        overViewcolor.backgroundColor = defaultColor
        profileColor.backgroundColor = defaultColor
        rewardsColor.backgroundColor = defaultColor
        companiesColor.backgroundColor = defaultColor
        
        overViewLable.textColor = defaultText
        profileLabel.textColor = defaultText
        rewardsLabel.textColor = defaultText
        companiesLabel.textColor = defaultText
    }
    func selectTab(colorView: UIView, label: UILabel) {
        let selectedColor = #colorLiteral(red: 0.1960784314, green: 0.8039215686, blue: 0.03807460484, alpha: 1)
        
        colorView.isHidden = false
        colorView.backgroundColor = selectedColor
        label.textColor = selectedColor
    }
    
}
extension ProfileVc: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectFavouriteActivityCell", for: indexPath) as! SelectFavouriteActivityCell
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.bounds.height
        let width = collectionView.bounds.width/3
        return CGSize(width: width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func bookingBtnAction() {
        firstView.BookingAction = {
            let nav = self.storyboard?.instantiateViewController(withIdentifier: "BookingVC") as! BookingVC
            
            self.navigationController?.pushViewController(nav, animated: true)
        }

    }
    func wishlistBtnAction() {
        firstView.WishListAction = {
//            let nav = self.storyboard?.instantiateViewController(withIdentifier: "WishListVC") as! WishListVC
//            nav.hidevalue = "ok"
//            self.navigationController?.pushViewController(nav, animated: true)
            
            self.tabBarController?.selectedIndex = 2
        }
    }
    func plusCompannyActionBtn() {
        fourthView.addMoreCampanyActionBtn = {
            let nav = self.storyboard?.instantiateViewController(withIdentifier: "BussinessProfileSetupVc") as! BussinessProfileSetupVc
            
            self.navigationController?.pushViewController(nav, animated: true)
        }
    }
}

