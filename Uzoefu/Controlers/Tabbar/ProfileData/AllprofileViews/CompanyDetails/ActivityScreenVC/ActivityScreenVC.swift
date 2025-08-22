import UIKit

struct Section {
    let title: String
    let content: [String]
    var isExpanded: Bool
}

class ActivityScreenVC: UIViewController {
    
    @IBOutlet weak var companyDetailCollectionViewSecond: UICollectionView!
    @IBOutlet weak var companyDetailCollectionView: UICollectionView!
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
    
    var sections: [Section] = [
        Section(title: "Activity Hours", content: [
            "Mon       09:00 - 17:00",
            "Tue       09:00 - 17:00",
            "Wed       09:00 - 17:00"
        ], isExpanded: false),
        
        Section(title: "Amenities", content: ["Parking", "WiFi"], isExpanded: false),
        
        Section(title: "Terms & Conditions", content: ["No refund after booking"], isExpanded: false),
        
        Section(title: "Indemnity", content: ["You will be kindly requested to sign..."], isExpanded: false)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load Nib Views
        firstView = (Bundle.main.loadNibNamed("OverViewClassUiView", owner: self, options: nil)![0] as! OverViewClassUiView)
        secondView = (Bundle.main.loadNibNamed("InformationClassUiView", owner: self, options: nil)![0] as! InformationClassUiView)
        thirdView = (Bundle.main.loadNibNamed("ReviewsClassUiView", owner: self, options: nil)![0] as! ReviewsClassUiView)
        fourthView = (Bundle.main.loadNibNamed("FAQClassUiView", owner: self, options: nil)![0] as! FAQClassUiView)
        
        loadNib = [firstView, secondView, thirdView, fourthView]
        
        for i in loadNib {
            i.frame = containerView.bounds
            containerView.addSubview(i)
        }
        containerView.clipsToBounds = true
        containerView.bringSubviewToFront(loadNib[0])
        
        // CollectionViews
        companyDetailCollectionView.delegate = self
        companyDetailCollectionView.dataSource = self
        companyDetailCollectionViewSecond.delegate = self
        companyDetailCollectionViewSecond.dataSource = self
        
        let layout1 = UICollectionViewFlowLayout()
        layout1.scrollDirection = .horizontal
        companyDetailCollectionView.collectionViewLayout = layout1
        companyDetailCollectionView.showsHorizontalScrollIndicator = false
        
        let layout2 = UICollectionViewFlowLayout()
        layout2.scrollDirection = .horizontal
        companyDetailCollectionViewSecond.collectionViewLayout = layout2
        companyDetailCollectionViewSecond.showsHorizontalScrollIndicator = false
        
        // Table
        loadInforamtionCell()
        loadReviewsCell()
        secondView.informationTbale.rowHeight = UITableView.automaticDimension
        secondView.informationTbale.estimatedRowHeight = 60
        
        companyDetailCollectionView.contentInsetAdjustmentBehavior = .never
    
        
    }
    
    // MARK: - Expand / Collapse
    @objc func toggleSection(_ sender: UIButton) {
        let section = sender.tag
        sections[section].isExpanded.toggle()
        
        secondView.informationTbale.beginUpdates()
        secondView.informationTbale.reloadSections(IndexSet(integer: section), with: .automatic)
        secondView.informationTbale.endUpdates()
    }
    
    // MARK: - Tab Actions
    @IBAction func overviewActionBtn(_ sender: UIButton) {
       
        resetAllTabs()
        selectTab(colorView: overViewcolor, label: overViewLable)
        containerView.bringSubviewToFront(loadNib[0])
    }
    
    @IBAction func informationActionBtn(_ sender: UIButton) {
      //  picLanguagecontraint.constant = 0
        resetAllTabs()
        selectTab(colorView: informationView, label: informationLable)
        containerView.bringSubviewToFront(loadNib[1])
    }
    
    @IBAction func reviewsActionBtn(_ sender: Any) {
       
        resetAllTabs()
        selectTab(colorView: reviewsView, label: reviewsLable)
        containerView.bringSubviewToFront(loadNib[2])
    }
    
    @IBAction func faqActionbtn(_ sender: UIButton) {
     
        resetAllTabs()
        selectTab(colorView: faqViews, label: faqLable)
        containerView.bringSubviewToFront(loadNib[3])
    }
    
    @IBAction func BackBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - CollectionView
extension ActivityScreenVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == companyDetailCollectionView ? 3 : 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == companyDetailCollectionView {
            let cell = companyDetailCollectionView.dequeueReusableCell(withReuseIdentifier: "CompanyDetailsCell", for: indexPath) as! CompanyDetailsCell
            return cell
        } else {
            let cell = companyDetailCollectionViewSecond.dequeueReusableCell(withReuseIdentifier: "CompanyDetailsCellSecond", for: indexPath)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == companyDetailCollectionView {
            return CGSize(width: companyDetailCollectionView.bounds.width, height: 240)
        } else {
            let size = collectionView.bounds.width / 5
            return CGSize(width: size, height: 80)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat { 
        if collectionView == companyDetailCollectionViewSecond {
            return 10
        }
        else {
            return 2
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat { return 5 }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == companyDetailCollectionView {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right:0)
        }
        else {
            return UIEdgeInsets(top: 10, left: 5, bottom: 0, right: 5)
        }
        
    }
}

// MARK: - Helper
extension ActivityScreenVC {
    func resetAllTabs() {
        let defaultColor = #colorLiteral(red: 0.4512393475, green: 0.4832214117, blue: 0.4951165318, alpha: 1)
        let defaultText = defaultColor
        
        overViewcolor.isHidden = true
        informationView.isHidden = true
        reviewsView.isHidden = true
        faqViews.isHidden = true
        
        overViewcolor.backgroundColor = defaultColor
        informationView.backgroundColor = defaultColor
        reviewsView.backgroundColor = defaultColor
        faqViews.backgroundColor = defaultColor
        
        overViewLable.textColor = defaultText
        informationLable.textColor = defaultText
        reviewsLable.textColor = defaultText
        faqLable.textColor = defaultText
    }
    
    func selectTab(colorView: UIView, label: UILabel) {
        let selectedColor = #colorLiteral(red: 0.1960784314, green: 0.8039215686, blue: 0.03807460484, alpha: 1)
        colorView.isHidden = false
        colorView.backgroundColor = selectedColor
        label.textColor = selectedColor
    }
    
    func loadInforamtionCell() {
        let nib = UINib(nibName: "InformationTabelCell", bundle: nil)
        secondView.informationTbale.register(nib, forCellReuseIdentifier: "InformationTabelCell")
        secondView.informationTbale.delegate = self
        secondView.informationTbale.dataSource = self
    }
    func loadReviewsCell() {
        let nib = UINib(nibName: "ReviewCellClass", bundle: nil)
        thirdView.ReviewsTableView.register(nib, forCellReuseIdentifier: "ReviewCellClass")
        thirdView.ReviewsTableView.delegate = self
        thirdView.ReviewsTableView.dataSource = self
    }
}

// MARK: - TableView

extension ActivityScreenVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == secondView.informationTbale {
            return sections.count
        } else {
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == secondView.informationTbale {
            // 1 row hamesha (header row), aur agar expand hai to content bhi add hoga
            return sections[section].isExpanded ? sections[section].content.count + 1 : 1
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == secondView.informationTbale {
            let section = sections[indexPath.section]
            
            if indexPath.row == 0 {
                // Header Cell
                let cell = tableView.dequeueReusableCell(withIdentifier: "InformationTabelCell", for: indexPath) as! InformationTabelCell
                cell.titleLabel.text = section.title
                cell.toggleButton.tag = indexPath.section
                cell.toggleButton.setTitle(section.isExpanded ? "-" : "+", for: .normal)
                cell.toggleButton.addTarget(self, action: #selector(toggleSection(_:)), for: .touchUpInside)
                cell.selectionStyle = .none
                return cell
            } else {
                // Content Cell
                let cell = tableView.dequeueReusableCell(withIdentifier: "InformationTabelCell", for: indexPath) as! InformationTabelCell
                cell.titleLabel.text = section.content[indexPath.row - 1]
                cell.selectionStyle = .none
                return cell
            }
        } else {
            let cell = thirdView.ReviewsTableView.dequeueReusableCell(withIdentifier: "ReviewCellClass", for: indexPath) as! ReviewCellClass
            cell.selectionStyle = .none
            return cell
        }
    }

}

