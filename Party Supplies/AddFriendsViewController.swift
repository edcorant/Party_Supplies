//
//  AddFriendsViewController.swift
//  Party Supplies
//
//  Created by Andre Guiraud on 11/14/20.
//

import UIKit
import Parse

class AddFriendsViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var foundUsers = [PFUser]()
    var friends: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // print("Friends:", friends!)
            
        tableView.dataSource = self
        tableView.delegate = self
        
        searchBar.delegate = self
        searchBar.autocapitalizationType = .none
        searchBar.autocorrectionType = .no
        searchBar.spellCheckingType = .no
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foundUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "findfriendsCell") as! AddFriendsTableViewCell
        let user  = foundUsers[indexPath.row]
        cell.usernameLabel.text = user.username!
        cell.requestButton.tag = indexPath.row
        cell.requestButton.addTarget(self, action: #selector(sendRequestTo), for: .touchUpInside)
        
        return cell
    }
    
    @objc func sendRequestTo(sender: UIButton!) {
        let userToAdd = foundUsers[sender.tag]
        let request = PFObject(className: "friendRequest")
        request["fromUser"] = PFUser.current()
        request["toUser"] = userToAdd
        request["status"] = "requested"
        request.saveInBackground { (success, error) in
            if success {
                print("Request sent successfully.")
                sender.removeFromSuperview()
            }
            else {
                print("Could not send request to user \(userToAdd)")
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // print(searchBar.text!)
        searchUser()
    }
    
    func searchUser() {
        // print("Search User")
        let query = PFQuery(className: "_User")
        query.whereKey("username", notContainedIn: friends!)
        query.whereKey("username", notEqualTo: PFUser.current()!.username!)
        query.whereKey("username", hasPrefix: searchBar.text)
        query.findObjectsInBackground { (users, error) in
            if let users = users as? [PFUser] {
                self.foundUsers = users
                // print(self.foundUsers)
                self.tableView.reloadData()
            }
        }
    }
    
}
