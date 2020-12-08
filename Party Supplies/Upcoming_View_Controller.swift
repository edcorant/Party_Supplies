//
//  Upcoming_View_Controller.swift
//  Party Supplies
//
//  Created by Eduardo Antonini on 12/7/20.
//

import UIKit
import Parse

class Upcoming_View_Controller: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var table_view: UITableView!
    
    var parties: [PFObject]!
    var user: PFUser?
    var friends = [PFUser]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table_view.dataSource = self
        table_view.delegate = self
        user = PFUser.current()
        getFriendsForUser()
        get_parties()
    }
    
    func get_parties() {
        
        /*
         select parties
         from users
         where user in currentuser.friends
         */
        
        let query = PFQuery(className: "Parties")
        query.whereKey("Owner", containedIn: friends)
        query.whereKey("Owner", equalTo: user!)
        query.findObjectsInBackground { (parties, error) in
            if let parties = parties {
                self.parties = parties
                self.table_view.reloadData()
            }
        }
    }
    
    func getFriendsForUser(){
        let relation = user?.relation(forKey: "friends")
        let query = relation?.query()
        if let relationQuery = query
        {
            relationQuery.findObjectsInBackground { (friends, error) in
                if let friends = friends {
                    self.friends = friends as! [PFUser]
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "upcoming"
        {
            if let destination = segue.destination as? Upcoming_Party_View_Controller
            {
                let indexPath = table_view.indexPathForSelectedRow!
                destination.party = parties[indexPath.row]
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parties?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = table_view.dequeueReusableCell(withIdentifier: "Upcoming_Party_Item") as! Upcoming_Party_Item
        
        let party = parties[indexPath.row]

        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm E, d MMM y"
        
        cell.party_name.text = party["Name"] as? String
        cell.party_time.text = formatter.string(from: party["Date"] as! Date)
        cell.party_address.text = party["Address"] as? String
        
        return cell
    }
    

}
