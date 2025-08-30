//
//  ExploreexpericeFilter.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 25/08/25.
//

import UIKit

class ExploreexpericeFilter: UIViewController {
    
    @IBOutlet weak var exploretable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
extension ExploreexpericeFilter :UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
}
