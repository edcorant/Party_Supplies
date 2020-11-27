//
//  Sign_In_ViewController.swift
//  Party Supplies
//
//  Created by Eduardo Antonini on 11/3/20.
//

import UIKit
import Parse

class Sign_In_ViewController: UIViewController {
    
    @IBOutlet weak var username_text_field: UITextField!
    @IBOutlet weak var password_text_field: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func on_sign_in(_ sender: Any) {
        
        // get text values from textboxes
        let username = username_text_field.text!
        let password = password_text_field.text!
        
        // call this function to authenticate user in database
        PFUser.logInWithUsername(inBackground: username, password: password) {
          (user: PFUser?, error: Error?) -> Void in
            if user != nil {
                self.clear_textboxes()
                // if successful, go to feed view
                self.performSegue(withIdentifier: "user_authenticated", sender: nil)
                UserDefaults.standard.set(true, forKey: "userloggedin")
            }
            else {
                print("Error: Sign In Failed.")
            }
        }
        
    }
    
    @IBAction func on_sign_up(_ sender: Any) {
        
        // create a new user object
        let user = PFUser()
        // get text values from textboxes
        user.username = username_text_field.text
        user.password = password_text_field.text
        
        // call this function from to write new user to database
        user.signUpInBackground { (success, error) in
            if success {
                self.clear_textboxes()
                // if successful, go to feed view
                self.performSegue(withIdentifier: "user_authenticated", sender: nil)
            }
            
            else {
                print("Error: Sign Up Failed")
            }
        }
    }
    
    func clear_textboxes () {
        self.username_text_field.text = nil
        self.password_text_field.text = nil
    }
    
    // this will dismiss the keyboard when user taps elsewhere on the screen
    @IBAction func dismiss_keyboard(_ sender: Any) {
        view.endEditing(true)
    }
}
