//
//  FriendsScreenViewController.swift
//  Party Supplies
//
//  Created by Andre Guiraud on 11/13/20.
//

import UIKit
import Parse

class FriendsScreenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    var user: PFUser?
    var friends = [PFUser]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        user = PFUser.current()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getFriendsForUser()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // print("Rows:", friends.count)
        return friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell") as! FriendsTableViewCell
        let friend = friends[indexPath.row]
        cell.usernameLabel.text = friend.username!
        
        return cell
    }

    func getFriendsForUser(){
        let relation = user?.relation(forKey: "friends")
        let query = relation?.query()
        if let relationQuery = query
        {
            relationQuery.findObjectsInBackground { (friends, error) in
                if let friends = friends {
                    self.friends = friends as! [PFUser]
                    self.tableView.reloadData()
                }
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addFriends"
        {
            var friendsArray = [String]()
            
            for user in friends
            {
                friendsArray.append(user.username!)
            }
            
            if let destination = segue.destination as? AddFriendsViewController
            {
                destination.friends = friendsArray
            }
        }
    }

}
