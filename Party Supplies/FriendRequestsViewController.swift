//
//  FriendRequestsViewController.swift
//  Party Supplies
//
//  Created by Andre Guiraud on 11/14/20.
//

import UIKit
import Parse

class FriendRequestsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var user = PFUser.current()!
    var requests = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getRequests()
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return requests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendrequestCell") as! FriendRequestTableViewCell
        let userData = requests[indexPath.row]
        cell.request = userData
        cell.usernameLabel.text = (userData["fromUser"] as! PFUser).username!
        
        return cell
    }

    
    func getRequests() {
        let query = PFQuery(className: "friendRequest")
        query.whereKey("toUser", equalTo: user)
        query.whereKey("status", equalTo: "requested")
        query.includeKey("fromUser")
        query.findObjectsInBackground { (requests, error) in
            if let requests = requests {
                self.requests = requests
                self.tableView.reloadData()
            }
        }
    }
}
