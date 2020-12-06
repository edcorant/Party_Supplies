//
//  AddSuppliesViewController.swift
//  Party Supplies
//
//  Created by Andre Guiraud on 12/5/20.
//

import UIKit
import Parse

class AddSuppliesViewController: UIViewController {

    @IBOutlet weak var supplyTextField: UITextField!
    var delegate: ModalHandler?
    
    var partyId: String!
    var party: PFObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let query = PFQuery(className: "Parties")
        query.whereKey("objectId", equalTo: partyId!)
        query.findObjectsInBackground { (party, error) in
            if let party = party {
                self.party = party[0]
            }
        }
    }
    
    @IBAction func onAddSupply(_ sender: Any) {
        if supplyTextField.text != "" {
            let supply = supplyTextField.text!
            if party["Supplies"] == nil {
                var temp = [String]()
                temp.append(supply)
                party["Supplies"] = temp
            }
            else {
                var supplies = party["Supplies"] as! Array<String>
                supplies.append(supply)
                party["Supplies"] = supplies
            }
            party.saveInBackground { (success, error) in
                if let error = error {
                    print("Failed to save supply with error: \(error.localizedDescription).")
                }
            }
            self.dismiss(animated: true, completion: {
                self.delegate?.modalDismissed()
            })
        }
    }
    
}
