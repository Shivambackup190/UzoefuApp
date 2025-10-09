//
//  ExploreexpericeFilter.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 25/08/25.
//
protocol ExploreexpericeFilterDelegate: AnyObject {
    func didSelectActivity(activityID: Int)
}

import UIKit

class ExploreexpericeFilter: UIViewController {
    
    var searchactivityObj: SearchActivityModel?

    @IBOutlet weak var seachTextTF: UISearchBar!
   
    @IBOutlet weak var exploretable: UITableView!
    weak var delegate: ExploreexpericeFilterDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        seachTextTF.delegate = self
        exploretable.delegate = self
        exploretable.dataSource = self
    }
}

extension ExploreexpericeFilter: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchactivityObj?.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ExploreexpericeFilterCell
        cell.selectionStyle = .none
        
        if let activity = searchactivityObj?.data?[indexPath.row] {
            cell.activitynameListLable?.text = activity.name ?? ""
            cell.categoryListnameLabel?.text = activity.category_name ?? ""
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedActivity = searchactivityObj?.data?[indexPath.row] else { return }
        let activityID = selectedActivity.activity_id ?? 0
        print("✅ Selected Activity ID: \(activityID)")

        // Inform the presenting VC
        delegate?.didSelectActivity(activityID: activityID)

        // Dismiss modal
        dismiss(animated: true)
    }
    }


// MARK: - Search API Call
extension ExploreexpericeFilter {
    func SearchActivityListApi(searchText: String) {
        var param = [String: Any]()
        param = ["activity_name": searchText]
        
        SearchActivityViewModel.SearchActivityListApi(viewController: self, parameters: param as NSDictionary) { response in
            self.searchactivityObj = response
            DispatchQueue.main.async {
                self.exploretable.reloadData()
            }
        }
    }
}

// MARK: - UISearchBarDelegate
extension ExploreexpericeFilter: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 1 {
            SearchActivityListApi(searchText: searchText)
        } else if searchText.isEmpty {
            searchactivityObj = nil
            exploretable.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if let text = searchBar.text {
            SearchActivityListApi(searchText: text)
        }
        searchBar.resignFirstResponder()
    }
}
