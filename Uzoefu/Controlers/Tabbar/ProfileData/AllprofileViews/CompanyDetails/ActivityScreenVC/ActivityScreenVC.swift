import UIKit


struct Section {
    let title: String
    let content: [String]
    var isExpanded: Bool
}

class ActivityScreenVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // MARK: - Data
    var arr = ["Phone", "Map", "Add to Trip", "Trip Planner","Share"]
    var imagename = ["phone-call", "map", "Trip Planner","honeymoon", "shareimg"]
    var currentIndex = 0

    let imagePicker = UIImagePickerController()
    var selectedImages: [UIImage] = []
    var activityListdetailModelObj:ActivityDetailModel?
    var didselctletCategoryId :Int?

    // MARK: - IBOutlets
    @IBOutlet weak var popoverView: UIView!
    @IBOutlet weak var blurView: UIView!
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
    @IBOutlet weak var reviewPhotoCellCollectionView: UICollectionView!
    
    @IBOutlet weak var postButton: UIButton!
    @IBOutlet weak var reviewPhotoCellCollectionViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var categoryNameLabel: UILabel!
    
    @IBOutlet weak var activity_nameLable: UILabel!
    
    @IBOutlet weak var priceLable: UILabel!
    // MARK: - Nib loaded views
    var firstView: OverViewClassUiView!
    var secondView: InformationClassUiView!
    var thirdView: ReviewsClassUiView!
    var fourthView: FAQClassUiView!
    var loadNib = [UIView]()

    // MARK: - Expandable sections
    var sections = ["Activity Hours", "Amenities", "Terms & Conditions", "Indemnity"]
    var faqsections = ["What is the cancellation policy?", "Are there any medical conditions that would prevent me from participating?", "What happens in case of bad weather?", "What equipment is provided, and what should I bring?"]
    var expandedSection: [Bool] = []
    var expandedSectionFAQ: [Bool] = []

   // let experienceImg = Array(repeating: "experienceImg", count: 12)

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
      
     print(didselctletCategoryId)
        
        
        imagePicker.delegate = self
        companyDetailCollectionView.contentInsetAdjustmentBehavior = .never

        // load nib views
        firstView = Bundle.main.loadNibNamed("OverViewClassUiView", owner: self, options: nil)![0] as? OverViewClassUiView
        secondView = Bundle.main.loadNibNamed("InformationClassUiView", owner: self, options: nil)![0] as? InformationClassUiView
        thirdView = Bundle.main.loadNibNamed("ReviewsClassUiView", owner: self, options: nil)![0] as? ReviewsClassUiView
        fourthView = Bundle.main.loadNibNamed("FAQClassUiView", owner: self, options: nil)![0] as? FAQClassUiView

        loadNib = [firstView, secondView, thirdView, fourthView].compactMap { $0 }

        for v in loadNib {
            v.translatesAutoresizingMaskIntoConstraints = true
            v.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }

        // initial container
        if let first = firstView {
            first.frame = containerView.bounds
            containerView.addSubview(first)
            containerView.clipsToBounds = true
            currentIndex = 0
        }

        // CollectionView delegates & dataSources
        companyDetailCollectionView.delegate = self
        companyDetailCollectionView.dataSource = self
        companyDetailCollectionViewSecond.delegate = self
        companyDetailCollectionViewSecond.dataSource = self
        communicationCollection.delegate = self
        communicationCollection.dataSource = self
        reviewPhotoCellCollectionView.delegate = self
        reviewPhotoCellCollectionView.dataSource = self

        // layout setup
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

        self.blurView.isHidden = true

        // table setup and nib registration
        loadInforamtionCell()
        loadFaqcells()
        loadReviewsCell()

        BookingActionBtn()
        BookingActionBtninfo()
        BookingActionBtnfaq()
        writereviewAction()

        // expandable states
        expandedSection = Array(repeating: false, count: sections.count)
        expandedSectionFAQ = Array(repeating: false, count: faqsections.count)

        // table delegates
        secondView.informationTbale.delegate = self
        secondView.informationTbale.dataSource = self
        fourthView.faqTableView.delegate = self
        fourthView.faqTableView.dataSource = self
        fourthView.faqTableView.separatorStyle = .none

        // row height
        secondView.informationTbale.rowHeight = UITableView.automaticDimension
        secondView.informationTbale.estimatedRowHeight = 60
        fourthView.faqTableView.rowHeight = UITableView.automaticDimension
        fourthView.faqTableView.estimatedRowHeight = 60

        // gestures for container swiping
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeLeft.direction = .left
        containerView.addGestureRecognizer(swipeLeft)

        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeRight.direction = .right
        containerView.addGestureRecognizer(swipeRight)

        popoverView.layer.cornerRadius = 20
        popoverView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]

        resetAllTabs()
        selectTab(colorView: overViewcolor, label: overViewLable)
    }
    override func viewWillAppear(_ animated: Bool) {
       // reviewPhotoCellCollectionViewHeight.constant = 0
        activityListdetailApi(category_id: didselctletCategoryId ?? 0)
    }

    // MARK: - Tabs & Swipes
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
        guard index != currentIndex, index >= 0, index < loadNib.count else { return }

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
            // update tab UI after animation completes
            self.resetAllTabs()
            switch index {
            case 0: self.selectTab(colorView: self.overViewcolor, label: self.overViewLable)
            case 1: self.selectTab(colorView: self.informationView, label: self.informationLable)
            case 2: self.selectTab(colorView: self.reviewsView, label: self.reviewsLable)
            case 3: self.selectTab(colorView: self.faqViews, label: self.faqLable)
            default: break
            }
            self.currentIndex = index
        })
    }

    // MARK: - Tab IBActions
    @IBAction func overviewActionBtn(_ sender: UIButton) { changeTab(index: 0) }
    @IBAction func informationActionBtn(_ sender: UIButton) { changeTab(index: 1) }
    @IBAction func reviewsActionBtn(_ sender: Any) { changeTab(index: 2) }
    @IBAction func faqActionbtn(_ sender: UIButton) { changeTab(index: 3) }

    @IBAction func BackBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func sideMenuActionBtn(_ sender: UIButton) {
        let nav = self.storyboard?.instantiateViewController(withIdentifier: "SettingsVC") as! SettingsVC
        self.navigationController?.pushViewController(nav, animated: true)
    }

    @IBAction func dismissBlurAction(_ sender: UIButton) {
        blurView.isHidden = true
    }

    @IBAction func uploadPhotoAction(_ sender: UIButton) {
        let alert = UIAlertController(title: Constant.CHOOSE_IMAGE, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: Constant.GALLERY, style: .default, handler: { _ in
            self.openGallary()
            
        }))
        alert.addAction(UIAlertAction.init(title: Constant.CANCEL, style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    // MARK: - Helper UI functions
    func resetAllTabs() {
        let defaultColor = UIColor(red: 0.451, green: 0.483, blue: 0.495, alpha: 1)
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
        let selectedColor = UIColor(red: 0.196, green: 0.8039, blue: 0.03807, alpha: 1)
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

    // Booking actions
    func BookingActionBtn() {
        firstView.BookingActionBtn = { [weak self] in
            guard let self = self else { return }
            let nav = self.storyboard?.instantiateViewController(withIdentifier: "BookActivityStepIstVc") as! BookActivityStepIstVc
            self.navigationController?.pushViewController(nav, animated: true)
        }
    }
    func BookingActionBtninfo() {
        secondView.BookingActionBtnInformation = { [weak self] in
            guard let self = self else { return }
            let nav = self.storyboard?.instantiateViewController(withIdentifier: "BookActivityStepIstVc") as! BookActivityStepIstVc
            self.navigationController?.pushViewController(nav, animated: true)
        }
    }
    func BookingActionBtnfaq() {
        fourthView.BookingActionBtnfaq = { [weak self] in
            guard let self = self else { return }
            let nav = self.storyboard?.instantiateViewController(withIdentifier: "BookActivityStepIstVc") as! BookActivityStepIstVc
            self.navigationController?.pushViewController(nav, animated: true)
        }
    }
    func writereviewAction() {
        
        thirdView.writereviewbtnAction = { [weak self] in
            self?.blurView.isHidden = false
        }
    }

    // MARK: - Image picker helpers
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: Constant.BLANK, message: Constant.BLANK, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

    func openGallary() {
  
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        let img = (info[.originalImage] as? UIImage) ?? (info[.editedImage] as? UIImage)
        if let img = img {
            selectedImages.append(img)
            reviewPhotoCellCollectionViewHeight.constant = 145
            reviewPhotoCellCollectionView.reloadData()
        }
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - UICollectionView
extension ActivityScreenVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == companyDetailCollectionView {
            return 3
        } else if collectionView == companyDetailCollectionViewSecond {
            return min( self.activityListdetailModelObj?.data?.images.count ?? 0, 5)
        } else if collectionView == communicationCollection {
            return min(arr.count, imagename.count)
        } else if collectionView == reviewPhotoCellCollectionView {
            return selectedImages.count
        }
        return 0
    }
//ijgbioj
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if collectionView == companyDetailCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CompanyDetailsCell", for: indexPath) as! CompanyDetailsCell
            return cell

        } else if collectionView == companyDetailCollectionViewSecond {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "CompanyDetailsCellSecondImages",
                for: indexPath
            ) as! CompanyDetailsCellSecondImages

            if let images = self.activityListdetailModelObj?.data?.images, indexPath.row < images.count {
                let totalImages = images.count
                let basePath = self.activityListdetailModelObj?.image_path ?? "https://mobappssolutions.in/uzoefu/public/images/activity_images"

                if indexPath.item == 4 && totalImages > 5 {
                    let remaining = totalImages - 5
                    cell.countLabel.isHidden = false
                    cell.countLabel.text = "+\(remaining)"
                } else {
                    cell.countLabel.isHidden = true
                }

                if let imgName = images[indexPath.item].image {
                    let fullURL = "\(basePath)/\(imgName)"
                    print("Loading image: \(fullURL)") // 🔎 Debug
                    cell.imageView.sd_setImage(with: URL(string: fullURL), placeholderImage: UIImage(named: "placeholder"))
                }
            }

            return cell
        } else if collectionView == communicationCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "communication", for: indexPath) as! communicationCell
       
            cell.communicationLabel.text = arr[indexPath.row]
            cell.communicationImage.image = UIImage(named: imagename[indexPath.row])
            return cell

        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reviewPhotoCell", for: indexPath) as! reviewPhotoCell
            cell.uploardimages.image = selectedImages[indexPath.row]
            
            cell.cancelButton = { [weak self] in
                guard let self = self else { return }
                if indexPath.row < self.selectedImages.count {
                    self.selectedImages.remove(at: indexPath.row)
                    self.reviewPhotoCellCollectionView.reloadData()
                }
            }
            return cell
        }
    }

    // Layout delegates
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == companyDetailCollectionView {
            return CGSize(width: collectionView.bounds.width, height: 240)
        } else if collectionView == companyDetailCollectionViewSecond {
            let size = collectionView.bounds.width / 5
            return CGSize(width: size, height: 80)
        } else if collectionView == communicationCollection {
            let width = communicationCollection.bounds.width
            return CGSize(width: width / 4, height: 50)
        } else { // reviewPhotoCellCollectionView
            return CGSize(width: 80, height: 80)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return collectionView == companyDetailCollectionViewSecond ? 5 : 2
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == companyDetailCollectionView {
            return .zero
        } else {
            return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        }
    }
}

// MARK: - UITableView (expandable)
extension ActivityScreenVC: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == secondView.informationTbale {
            return sections.count
        } else if tableView == thirdView.ReviewsTableView {
            return 1
        } else if tableView == fourthView.faqTableView {
            return faqsections.count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == secondView.informationTbale {
            return expandedSection[section] ? 1 : 0
        } else if tableView == fourthView.faqTableView {
            return expandedSectionFAQ[section] ? 1 : 0
        } else if tableView == thirdView.ReviewsTableView {
            return 5
        }
        return 0
    }

    // Header view
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor(red: 0.9608, green: 0.9647, blue: 0.9647, alpha: 1)
        headerView.tag = section

        if #available(iOS 15.0, *) {
            secondView.informationTbale.sectionHeaderTopPadding = 10
            fourthView.faqTableView.sectionHeaderTopPadding = 10
        }

        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        titleLabel.textColor = UIColor.systemGray
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
            headerView.accessibilityIdentifier = "info"
        } else if tableView == fourthView.faqTableView {
            titleLabel.text = faqsections[section]
            let imageName = expandedSectionFAQ[section] ? "minus_icon" : "plus_icon"
            iconView.image = UIImage(named: imageName)
            headerView.accessibilityIdentifier = "faq"
        } else {
            titleLabel.text = ""
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

    // Header tap handler (uses accessibilityIdentifier to decide which table)
    @objc func handleHeaderTap(_ gesture: UITapGestureRecognizer) {
        guard let headerView = gesture.view else { return }
        let section = headerView.tag
        let id = headerView.accessibilityIdentifier

        if id == "info" {
            expandedSection[section].toggle()
            secondView.informationTbale.reloadSections(IndexSet(integer: section), with: .automatic)
        } else if id == "faq" {
            expandedSectionFAQ[section].toggle()
            fourthView.faqTableView.reloadSections(IndexSet(integer: section), with: .automatic)
        }
    }

    // Header height
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == secondView.informationTbale || tableView == fourthView.faqTableView {
            return UITableView.automaticDimension
        }
        return CGFloat.leastNormalMagnitude
    }

    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    // Toggle actions (if you prefer button-driven toggles)
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

    // Cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

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
        } else if tableView == thirdView.ReviewsTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCellClass", for: indexPath) as! ReviewCellClass
            cell.selectionStyle = .none
            return cell
        } else if tableView == fourthView.faqTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FAQCell", for: indexPath) as! FAQCell
            cell.selectionStyle = .none
            return cell
        }

        return UITableViewCell()
    }
}
extension ActivityScreenVC {
    func activityListdetailApi(category_id: Int) {
        let param: [String: Any] = ["activity_id": didselctletCategoryId ?? 0]
        print(param)
        
        ActivityDetailViewModel.activitydetailListApi(viewController: self, parameters: param as NSDictionary) { response in
            self.activityListdetailModelObj = response
            print("Api Suceess Called")
            self.companyDetailCollectionViewSecond.reloadData()
            self.categoryNameLabel.text = self.activityListdetailModelObj?.data?.activity?.category?.name ?? "No Category"
            self.activity_nameLable.text = self.activityListdetailModelObj?.data?.activity?.activity_name ?? "No activity"
            self.priceLable.text = self.activityListdetailModelObj?.data?.price?.group_price ?? "0"
            self.firstView.descriptionTextLable.text = self.activityListdetailModelObj?.data?.description?.description ?? "Nice to Meet You!"
            let branchName = self.activityListdetailModelObj?.data?.activity?.branch?.branch_name ?? ""
            let town = self.activityListdetailModelObj?.data?.activity?.branch?.town ?? ""

            self.firstView.branchAndaddressLabel.text = "\(branchName), \(town)"
            let contactNumber = self.activityListdetailModelObj?.data?.activity?.branch?.contact_number ?? ""
            self.firstView.celllarNumber.text = contactNumber.isEmpty ? "" : "Tel: +\(contactNumber)"

            let cellularnum = self.activityListdetailModelObj?.data?.activity?.branch?.contact_number ?? ""
            self.firstView.celllarNumber.text = cellularnum.isEmpty ? "" : "Cel: +\(cellularnum)"

            
            
            
            if let highlights = self.activityListdetailModelObj?.data?.description?.highlights {
                let allHighlights = highlights.compactMap { $0.description }.joined(separator: "\n\n• ")
                self.firstView.highlight1.text = "• " + allHighlights
            }


        }
    }
}
