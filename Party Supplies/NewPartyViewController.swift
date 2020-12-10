//
//  NewPartyViewController.swift
//  Party Supplies
//
//  Created by Andre Guiraud on 11/27/20.
//

import UIKit
import Parse

enum PartyDataError: Error {
    case empty(String)
}

class NewPartyViewController: UIViewController {

    
    @IBOutlet weak var partyNameText: UITextField!
    @IBOutlet weak var partyAddresText: UITextField!
    @IBOutlet weak var partyDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func onCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onCreate(_ sender: Any){
        let party = PFObject(className: "Parties")
        
        party["Owner"] = PFUser.current()
        party["Owner_Username"] = PFUser.current()!.username
        party["Name"] = partyNameText.text!
        party["Date"] = partyDatePicker.date
        party["Address"] = partyAddresText.text!
        
        if partyNameText.text! != "" && partyAddresText.text! != ""
        {
            party.saveInBackground { (success, error) in
                if success {
                    print("Saved party!")
                }
                else {
                    print("Error: \(String(describing: error?.localizedDescription)).")
                }
                self.dismiss(animated: true, completion: nil)
            }
        }
        else
        {
            let alert = UIAlertController(title: "Error", message: "A party name and party address must be entered.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }

}
