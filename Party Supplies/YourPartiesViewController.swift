//
//  YourPartiesViewController.swift
//  Party Supplies
//
//  Created by Andre Guiraud on 11/27/20.
//

import UIKit
import Parse

class YourPartiesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var parties = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getParties()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parties.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "yourpartiesCell") as! YourPartiesTableViewCell
        let party = parties[indexPath.row]
        cell.partyNameLabel.text = party["Name"] as? String
        return cell
    }
    
    func getParties() {
        let query = PFQuery(className: "Parties")
        let user = PFUser.current()!
        query.whereKey("Owner", equalTo: user)
        query.findObjectsInBackground { (parties, error) in
            if let parties = parties {
                self.parties = parties
                self.tableView.reloadData()
            }
        }
        
    }

}
