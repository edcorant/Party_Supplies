//
//  PartyDetailsViewController.swift
//  Party Supplies
//
//  Created by Eduardo Antonini on 11/27/20.
//

import UIKit
import Parse

protocol ModalHandler {
    func modalDismissed()
}

class PartyDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ModalHandler {

    @IBOutlet weak var party_name: UILabel!
    @IBOutlet weak var party_address: UILabel!
    @IBOutlet weak var party_time: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var party: PFObject!
    var supplies: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm E, d MMM y"
        let date = party["Date"] as? Date
        party_name.text = party["Name"] as? String
        party_time.text = formatter.string(from: date!)
        party_address.text = party["Address"] as? String
        getSupplies()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let supplies = self.supplies
        {
            return supplies.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "partySuppliesCell") as! PartySuppliesTableViewCell
        cell.supplynameLabel.text = supplies[indexPath.row]
        return cell
    }
    
    func getSupplies() {
        let query = PFQuery(className: "Parties")
        query.whereKey("objectId", equalTo: party.objectId!)
        query.findObjectsInBackground { (party, error) in
            if let party = party {
                let myparty = party[0]
                self.supplies = myparty["Supplies"] as? Array<String>
                self.tableView.reloadData()
            }
        }
    }
    
    func modalDismissed() {
        self.getSupplies()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "partyaddSupplies"
        {
            if let destination = segue.destination as? AddSuppliesViewController
            {
                destination.partyId = self.party.objectId!
                destination.delegate = self
            }
        }
    }
}
