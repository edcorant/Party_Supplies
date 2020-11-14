//
//  YourProfileViewController.swift
//  Party Supplies
//
//  Created by Andre Guiraud on 11/13/20.
//

import UIKit
import Parse

class YourProfileViewController: UIViewController {

    @IBOutlet weak var userwelcomeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let user = PFUser.current()
        let username = (user?.username)! as String
        userwelcomeLabel.text = "Welcome back, \(username)"
        // Do any additional setup after loading the view.
    }
    

    @IBAction func onLogout(_ sender: Any) {
        PFUser.logOutInBackground { (error) in
            if let error = error {
                print(error.localizedDescription)
            }
            else {
                let main = UIStoryboard(name: "Main", bundle: nil)
                let signinViewController = main.instantiateViewController(withIdentifier: "Sign_In_ViewController")
                let sceneDelegate = self.view.window?.windowScene?.delegate as! SceneDelegate
                sceneDelegate.window?.rootViewController = signinViewController
            }
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
