//
//  New_Party_ViewController.swift
//  Party Supplies
//
//  Created by Eduardo Antonini on 11/10/20.
//

import UIKit
import Parse
import MapKit

class New_Party_ViewController: UIViewController {

    @IBOutlet weak var party_name_textbox: UITextField!
    @IBOutlet weak var party_address_textbox: UITextField!
    @IBOutlet weak var party_date_picker: UIDatePicker!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancel_button(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func create_button(_ sender: Any) {
        
        var address = party_address_textbox.text!
        
        // new object in "Posts" table
        let party = PFObject(className: "Parties")
        // upload object's owner
        party["Owner"] = PFUser.current()
        
        // upload address
        party["Place"] = getCoordinate(addressString: address, completionHandler: { (CLLocationCoordinate2D, _: NSError?) in
            // we need to figure out how to do this correctly
        })
        
        // upload party name
        party["Name"] = party_name_textbox.text!
        // party date
        party["Date"] = party_date_picker.date
        
        // flush post object to disc
        party.saveInBackground { (success, error) in
            if success {
                print("Success!")
            }
            
            else {
                print("Error: \(String(describing: error?.localizedDescription)).")
            }
            
            // dismiss current view
            self.cancel_button(0)
        }
    }
    
    /*
     below are possible ways to convert a user-entered address into a real
     pair of coordinates
     */
    
    // look into:  http://www.seanbehan.com/how-to-get-gps-location-information-from-address-string-with-swift-and-ios-clgeocoder/
    
    /*
     The function below shows how we might obtain a coordinate value from a user-provided string.
     The example calls the provided completion handler with only the first result. If the string
     does not correspond to any location, the method calls the completion handler with an error
     and an invalid coordinate.
     */
    func getCoordinate( addressString : String,
            completionHandler: @escaping(CLLocationCoordinate2D, NSError?) -> Void ) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(addressString) { (placemarks, error) in
            if error == nil {
                if let placemark = placemarks?[0] {
                    let location = placemark.location!
                        
                    completionHandler(location.coordinate, nil)
                    return
                }
            }
                
            completionHandler(kCLLocationCoordinate2DInvalid, error as NSError?)
        }
    }
    
}
