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
        // this comment added for testing purposes
    }
    
    @IBAction func on_sign_up(_ sender: Any) {
        
    }
    
}
