//
//  Upcoming_Party_View_Controller.swift
//  Party Supplies
//
//  Created by Eduardo Antonini on 12/7/20.
//

import UIKit
import Parse

class Upcoming_Party_View_Controller: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var party_name: UILabel!
    @IBOutlet weak var party_address: UILabel!
    @IBOutlet weak var party_time: UILabel!
    @IBOutlet weak var table_view: UITableView!
    
    var party: PFObject!
    var supplies: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table_view.delegate = self
        table_view.dataSource = self
        
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
        let cell = table_view.dequeueReusableCell(withIdentifier: "Upcoming_Party_Cell") as! Upcoming_Party_Cell
        cell.supply_name.text = supplies[indexPath.row]
        return cell
    }
    
    func getSupplies() {
        let query = PFQuery(className: "Parties")
        query.whereKey("objectId", equalTo: party.objectId!)
        query.findObjectsInBackground { (party, error) in
            if let party = party {
                let myparty = party[0]
                self.supplies = myparty["Supplies"] as? Array<String>
                self.table_view.reloadData()
            }
        }
    }

}
