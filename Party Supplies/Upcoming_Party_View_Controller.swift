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
        
        let supplies_checked = party["Supplies_Checked"] as? Array<String> ?? []
        
        cell.supply_name.text = supplies[indexPath.row]
        cell.supply_circle.tag = indexPath.row
        
        if supplies_checked.contains(cell.supply_name.text!) {
            cell.user_is_bringing = !cell.user_is_bringing
            cell.supply_circle.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        }
        
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
    
    @IBAction func onBringing(_ sender: UIButton) {
        let indexPath = IndexPath(row: sender.tag, section: 0)
        let cell = self.table_view.cellForRow(at: indexPath) as! Upcoming_Party_Cell
        
        cell.user_is_bringing = !cell.user_is_bringing
        
        if cell.user_is_bringing {
            cell.supply_circle.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
            
            if party["Supplies_Checked"] == nil {
                var temp = [String]()
                temp.append(cell.supply_name.text!)
                party["Supplies_Checked"] = temp
            }
            else {
                var supplies_checked = party["Supplies_Checked"] as! Array<String>
                supplies_checked.append(cell.supply_name.text!)
                party["Supplies_Checked"] = supplies_checked
                }
            }
        else {
            cell.supply_circle.setImage(UIImage(systemName: "circle"), for: .normal)
            
            var supplies_checked = party["Supplies_Checked"] as! Array<String>
            if let index = supplies_checked.firstIndex(of: cell.supply_name.text!) {
                supplies_checked.remove(at: index)
            }
            party["Supplies_Checked"] = supplies_checked
        }
        party.saveInBackground { (success, error) in
        if let error = error {
            print("Failed to save supply check with error: \(error.localizedDescription).")
            }
        }
    }
}
