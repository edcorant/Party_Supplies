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
        cell.requestButton.tag = indexPath.row     // getting a crash here
        cell.requestButton.addTarget(self, action: #selector(sendRequestTo(sender: cell.requestButton, row: indexPath.row)), for: .touchUpInside)
        
        return cell
    }
    
    @objc func sendRequestTo(sender: UIButton!, row: Int) {
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
        
        foundUsers.remove(at: row)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // print(searchBar.text!)
        if (searchBar.text != "") {
            searchUser()
        }
    }
    
    func searchUser() {
        // print("Search User")
        // initialize a new query
        let query = PFQuery(className: "_User")
        // look for people who are not currently in our list of friends
        query.whereKey("username", notContainedIn: friends!)
        // people who are not ourselves
        query.whereKey("username", notEqualTo: PFUser.current()!.username!)
        // people whose name matches the name we're searching for
        query.whereKey("username", hasPrefix: searchBar.text)
        
        query.findObjectsInBackground { (users, error) in
            if let users = users as? [PFUser] {
                self.foundUsers = users
                print(self.foundUsers)
                self.tableView.reloadData()
            }
        }
    }
    
}
