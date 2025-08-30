import UIKit
struct Section {
    let title: String
    let content: [String]
    var isExpanded: Bool
}

class ActivityScreenVC: UIViewController {
    
    var arr = ["Phone","map","Trip Planner", "Trip Planner"]
    var imagename = ["Call","Map","Add to Trip","Share"]
    var currentIndex = 0
    
    @IBOutlet weak var companyDetailCollectionViewSecond: UICollectionView!
    @IBOutlet weak var companyDetailCollectionView: UICollectionView!
    @IBOutlet weak var communicationCollection: UICollectionView!
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var overViewcolor: UIView!
    @IBOutlet weak var informationView: UIView!
    @IBOutlet weak var reviewsView: UIView!
    @IBOutlet weak var faqViews: UIView!
    
    @IBOutlet weak var overViewLable: UILabel!
    @IBOutlet weak var informationLable: UILabel!
    @IBOutlet weak var faqLable: UILabel!
    @IBOutlet weak var reviewsLable: UILabel!
    
    @IBOutlet weak var picLanguagecontraint: NSLayoutConstraint!
    
    var firstView: OverViewClassUiView!
    var secondView: InformationClassUiView!
    var thirdView: ReviewsClassUiView!
    var fourthView: FAQClassUiView!
    var loadNib = [UIView]()
    
    var sections = ["Activity Hours","Amenities","Terms & Conditions","Indemnity"]
    var faqsections = ["What is the cancellation policy?","Are there any medical conditions that would prevent me from participating?","What happens in case of bad weather?","What equipment is provided, and what should I bring?"]
    var expandedSectionFAQ = [Bool]()
    var expandedSection: [Bool] = []
    
    let experienceImg = Array(repeating: "experienceImg", count: 12)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        companyDetailCollectionView.contentInsetAdjustmentBehavior = .never
        
        firstView = (Bundle.main.loadNibNamed("OverViewClassUiView", owner: self, options: nil)![0] as! OverViewClassUiView)
        
        secondView = (Bundle.main.loadNibNamed("InformationClassUiView", owner: self, options: nil)![0] as! InformationClassUiView)
        
        thirdView = (Bundle.main.loadNibNamed("ReviewsClassUiView", owner: self, options: nil)![0] as! ReviewsClassUiView)
        
        fourthView = (Bundle.main.loadNibNamed("FAQClassUiView", owner: self, options: nil)![0] as! FAQClassUiView)
        
        loadNib = [firstView, secondView, thirdView, fourthView]
        
        for v in loadNib {
            v.translatesAutoresizingMaskIntoConstraints = true
            v.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }
        
        firstView.frame = containerView.bounds
        containerView.addSubview(firstView)
        containerView.clipsToBounds = true
        currentIndex = 0
        
        // CollectionViews setup
        companyDetailCollectionView.delegate = self
        companyDetailCollectionView.dataSource = self
        companyDetailCollectionViewSecond.delegate = self
        companyDetailCollectionViewSecond.dataSource = self
        communicationCollection.delegate = self
        communicationCollection.dataSource = self
        
        let layout1 = UICollectionViewFlowLayout()
        layout1.scrollDirection = .horizontal
        companyDetailCollectionView.collectionViewLayout = layout1
        companyDetailCollectionView.showsHorizontalScrollIndicator = false
        
        let layout2 = UICollectionViewFlowLayout()
        layout2.scrollDirection = .horizontal
        companyDetailCollectionViewSecond.collectionViewLayout = layout2
        companyDetailCollectionViewSecond.showsHorizontalScrollIndicator = false
        
        let layout3 = UICollectionViewFlowLayout()
        layout3.scrollDirection = .horizontal
        layout3.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        communicationCollection.collectionViewLayout = layout3
        communicationCollection.showsHorizontalScrollIndicator = false
        
        loadInforamtionCell()
        loadFaqcells()
        loadReviewsCell()
        BookingActionBtn()
        
        expandedSection = Array(repeating: false, count: sections.count)
        expandedSection[0] = false
        
        
        expandedSectionFAQ = Array(repeating: false, count: faqsections.count)
        expandedSectionFAQ[0] = false    // FAQ bhi first open
        
        
        secondView.informationTbale.delegate = self
        secondView.informationTbale.dataSource = self
        
        fourthView.faqTableView.delegate = self
        fourthView.faqTableView.dataSource = self
        fourthView.faqTableView.separatorStyle = .none
        
        
        secondView.informationTbale.rowHeight = UITableView.automaticDimension
        secondView.informationTbale.estimatedRowHeight = 60
        
        fourthView.faqTableView.rowHeight = UITableView.automaticDimension
        fourthView.faqTableView.estimatedRowHeight = 60
        
        
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
        case 1: selectTab(colorView: informationView, label: informationLable)
        case 2: selectTab(colorView: reviewsView, label: reviewsLable)
        case 3: selectTab(colorView: faqViews, label: faqLable)
        default: break
        }
        
        currentIndex = index
    }
    
    // MARK: - Tab Actions
    @IBAction func overviewActionBtn(_ sender: UIButton) { 
        changeTab(index: 0)
    }
    @IBAction func informationActionBtn(_ sender: UIButton) {
        changeTab(index: 1)
    }
    @IBAction func reviewsActionBtn(_ sender: Any) {
        changeTab(index: 2)
    }
    @IBAction func faqActionbtn(_ sender: UIButton) {
        changeTab(index: 3)
    }
    
    @IBAction func BackBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func sideMenuActionBtn(_ sender: UIButton) {
        let nav = self.storyboard?.instantiateViewController(withIdentifier: "SettingsVC") as! SettingsVC
        self.navigationController?.pushViewController(nav, animated: true)
    }
}

// MARK: - CollectionView
extension ActivityScreenVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == companyDetailCollectionView {
            return 3
        } else if collectionView == companyDetailCollectionViewSecond {
            return experienceImg.count > 5 ? 5 : experienceImg.count
        } else {
            return arr.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == companyDetailCollectionView {
            let cell = companyDetailCollectionView.dequeueReusableCell(withReuseIdentifier: "CompanyDetailsCell", for: indexPath) as! CompanyDetailsCell
            return cell
        } else if collectionView == companyDetailCollectionViewSecond {
            let cell = companyDetailCollectionViewSecond.dequeueReusableCell(withReuseIdentifier: "CompanyDetailsCellSecondImages", for: indexPath) as! CompanyDetailsCellSecondImages
            if experienceImg.count > 4 && indexPath.item == 4 {
                let remaining = experienceImg.count - 5
                cell.imageView.isHidden = false
                cell.countLabel.isHidden = false
                cell.countLabel.text = "+\(remaining)"
            } else {
                cell.imageView.isHidden = false
                cell.countLabel.isHidden = true
                cell.imageView.image = UIImage(named: experienceImg[indexPath.item])
            }
            return cell
        } else {
            let cell = communicationCollection.dequeueReusableCell(withReuseIdentifier: "communication", for: indexPath) as! communicationCell
            cell.communicationLabel.text = imagename[indexPath.row]
            cell.communicationImage.image = UIImage(named: arr[indexPath.row])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == companyDetailCollectionView {
            return CGSize(width: companyDetailCollectionView.bounds.width, height: 240)
        } else if collectionView == companyDetailCollectionViewSecond {
            let size = collectionView.bounds.width / 5
            return CGSize(width: size, height: 80)
        } else {
            let size = communicationCollection.bounds.width
            return CGSize(width: size/4, height: 50)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return collectionView == companyDetailCollectionViewSecond ? 5 : 2
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat { return 5 }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == companyDetailCollectionView {
            return .zero
        } else {
            return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        }
    }
}

// MARK: - Helper
extension ActivityScreenVC {
    func resetAllTabs() {
        let defaultColor = #colorLiteral(red: 0.4512393475, green: 0.4832214117, blue: 0.4951165318, alpha: 1)
        overViewcolor.isHidden = true
        informationView.isHidden = true
        reviewsView.isHidden = true
        faqViews.isHidden = true
        
        overViewcolor.backgroundColor = defaultColor
        informationView.backgroundColor = defaultColor
        reviewsView.backgroundColor = defaultColor
        faqViews.backgroundColor = defaultColor
        
        overViewLable.textColor = defaultColor
        informationLable.textColor = defaultColor
        reviewsLable.textColor = defaultColor
        faqLable.textColor = defaultColor
    }
    
    func selectTab(colorView: UIView, label: UILabel) {
        let selectedColor = #colorLiteral(red: 0.1960784314, green: 0.8039215686, blue: 0.03807460484, alpha: 1)
        colorView.isHidden = false
        colorView.backgroundColor = selectedColor
        label.textColor = selectedColor
    }
    
    func loadInforamtionCell() {
        let nib1 = UINib(nibName: "InformationTabelCell", bundle: nil)
        secondView.informationTbale.register(nib1, forCellReuseIdentifier: "InformationTabelCell")
        
        let nib2 = UINib(nibName: "AmenitiesCell", bundle: nil)
        secondView.informationTbale.register(nib2, forCellReuseIdentifier: "AmenitiesCell")
        
        let nib3 = UINib(nibName: "TermsConditionsCell", bundle: nil)
        secondView.informationTbale.register(nib3, forCellReuseIdentifier: "TermsConditionsCell")
        
        let nib4 = UINib(nibName: "IndemnityCell", bundle: nil)
        secondView.informationTbale.register(nib4, forCellReuseIdentifier: "IndemnityCell")
    }
    func loadFaqcells() {
        let nib1 = UINib(nibName: "FAQCell", bundle: nil)
        fourthView.faqTableView.register(nib1, forCellReuseIdentifier: "FAQCell")
        
    }
    func loadReviewsCell() {
        let nib = UINib(nibName: "ReviewCellClass", bundle: nil)
        thirdView.ReviewsTableView.register(nib, forCellReuseIdentifier: "ReviewCellClass")
        thirdView.ReviewsTableView.delegate = self
        thirdView.ReviewsTableView.dataSource = self
    }
    
    func BookingActionBtn() {
        firstView.BookingActionBtn = {
            let nav = self.storyboard?.instantiateViewController(withIdentifier: "BookActivityStepIstVc") as! BookActivityStepIstVc
            self.navigationController?.pushViewController(nav, animated: true)
        }
    }
}

// MARK: - TableView
extension ActivityScreenVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == secondView.informationTbale {
            return sections.count
        } else if tableView == thirdView.ReviewsTableView {
            return 1
        }
        return faqsections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == secondView.informationTbale {
            return expandedSection[section] ? 1 : 0
        } else if tableView == fourthView.faqTableView {
            return expandedSectionFAQ[section] ? 1 : 0
        }
        return 5
    }

    // MARK: - Header View
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
        
        headerView.tag = section
        if #available(iOS 15.0, *) {
            fourthView.faqTableView.sectionHeaderTopPadding = 10
            secondView.informationTbale.sectionHeaderTopPadding = 10
        }
        

        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        titleLabel.textColor = UIColor(hex: "#60686B")
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping

        let iconView = UIImageView()
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.tintColor = .black
        iconView.contentMode = .scaleAspectFit

        if tableView == secondView.informationTbale {
            titleLabel.text = sections[section]
            let imageName = expandedSection[section] ? "minus_icon" : "plus_icon"
            iconView.image = UIImage(named: imageName)
        } else if tableView == fourthView.faqTableView {
            titleLabel.text = faqsections[section]
            let imageName = expandedSectionFAQ[section] ? "minus_icon" : "plus_icon"
            iconView.image = UIImage(named: imageName)
        }


        headerView.addSubview(titleLabel)
        headerView.addSubview(iconView)

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 8),
            titleLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -8),

            iconView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            iconView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            iconView.leadingAnchor.constraint(greaterThanOrEqualTo: titleLabel.trailingAnchor, constant: 8)
        ])
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleHeaderTap(_:)))
        headerView.addGestureRecognizer(tapGesture)

        headerView.isUserInteractionEnabled = true

        return headerView
    }

    // MARK: - Header Tap Handler
    @objc func handleHeaderTap(_ gesture: UITapGestureRecognizer) {
        guard let headerView = gesture.view else { return }
        let section = headerView.tag

        if let tableView = headerView.superview as? UITableView {
            if tableView == secondView.informationTbale {
                expandedSection[section].toggle()
                tableView.reloadSections(IndexSet(integer: section), with: .automatic)
            } else if tableView == fourthView.faqTableView {
                expandedSectionFAQ[section].toggle()
                tableView.reloadSections(IndexSet(integer: section), with: .automatic)
            }
        }
    }


    // MARK: - Header Height
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == secondView.informationTbale || tableView == fourthView.faqTableView {
            return UITableView.automaticDimension
        }
        return CGFloat.leastNormalMagnitude
    }

    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    

    @objc func toggleSectionInfo(_ sender: UIButton) {
        let section = sender.tag
        expandedSection[section].toggle()
        secondView.informationTbale.reloadSections(IndexSet(integer: section), with: .automatic)
       
        
    }

    @objc func toggleSectionFaq(_ sender: UIButton) {
        let section = sender.tag
        expandedSectionFAQ[section].toggle()
        fourthView.faqTableView.reloadSections(IndexSet(integer: section), with: .automatic)
      
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 1. Information Table
        if tableView == secondView.informationTbale {
            switch indexPath.section {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "InformationTabelCell", for: indexPath) as! InformationTabelCell
                cell.selectionStyle = .none
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "AmenitiesCell", for: indexPath) as! AmenitiesCell
                cell.selectionStyle = .none
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: "TermsConditionsCell", for: indexPath) as! TermsConditionsCell
                cell.selectionStyle = .none
                return cell
            case 3:
                let cell = tableView.dequeueReusableCell(withIdentifier: "IndemnityCell", for: indexPath) as! IndemnityCell
                cell.selectionStyle = .none
                return cell
            default:
                let cell = UITableViewCell()
                cell.textLabel?.text = "Default Cell"
                cell.selectionStyle = .none
                return cell
            }
        }
        
        // 2. Reviews Table
        else if tableView == thirdView.ReviewsTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCellClass", for: indexPath) as! ReviewCellClass
            cell.selectionStyle = .none
            return cell
        }
        
        // 3. FAQ Table
        else if tableView == fourthView.faqTableView {
            switch indexPath.section {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "FAQCell", for: indexPath) as! FAQCell
                cell.selectionStyle = .none
                return cell
            default:
                let cell = UITableViewCell()
                cell.textLabel?.text = "Default Cell"
                cell.selectionStyle = .none
                return cell
            }
        }
        else {
            return UITableViewCell()
        }
    }
}
