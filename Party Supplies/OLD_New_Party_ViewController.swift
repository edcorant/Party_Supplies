//
//  New_Party_ViewController.swift
//  Party Supplies
//
//  Created by Eduardo Antonini on 11/10/20.
//

import UIKit
import Parse
import MapKit

class New_Party_ViewController: UIViewController
//                                CLLocationManagerDelegate , UITableViewDelegate ,UITableViewDataSource, UISearchBarDelegate
{

    @IBOutlet weak var party_name_textbox: UITextField!
    @IBOutlet weak var partyAddressTextbox: UITextField!
    @IBOutlet weak var party_date_picker: UIDatePicker!
//    var showingTableView : CGRect!
//    var removeTableView : CGRect!
//    let table_view = UITableView()
//    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        set_up_table_view()
        // Do any additional setup after loading the view.
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
//        // This triggers the location permission dialog. The user will only see the dialog once.
//        locationManager.requestWhenInUseAuthorization()
//        // This API call was introduced in iOS 9 and triggers a one-time location request.
//        locationManager.requestLocation()
//        location_search_bar.delegate = self
//        showingTableView = CGRect(x: 40, y: view.frame.height - 500, width: 400, height: 400)
//        removeTableView = CGRect(x: 40, y: view.frame.height, width: 400, height: 400)
    }
    
    @IBAction func cancel_button(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func create_button(_ sender: Any) {
                
        // new object in "Posts" table
        let party = PFObject(className: "Parties")
        // upload object's owner
        party["Owner"] = PFUser.current()
        
        // upload address
        // we want to have some kind of drop down menu where the user can search for and pick a location
        // party["Place"] = party_address_textbox.text!
        
        // upload party name
        party["Name"] = party_name_textbox.text!
        // party date
        party["Date"] = party_date_picker.date
        party["Address"] = partyAddressTextbox.text!
        
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
    
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        // print(searchBar.text!)
//        //display tableView
//        if searchText == ""{
//            display_table_view(frame: removeTableView)
//        }else{
//            display_table_view(frame: showingTableView)
//        }
//
//
//
//    }
    
//    func display_table_view(frame : CGRect){
//        UIView.animate(withDuration: 0.3, animations: {
//            //self.table_view.transform = CGAffineTransform(translationX: 0, y: 300)
//            // self.table_view.frame.y
//            self.table_view.frame = frame
//        }, completion: nil)
//
//    }
 
    
//    func set_up_table_view() {
//        table_view.dataSource = self
//        table_view.delegate = self
//        table_view.frame = CGRect(x: 40, y: view.frame.height, width: 400, height: 400)
//        view.addSubview(table_view)
//        table_view.backgroundColor = .red
//
//    }
    
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 10
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let cell = UITableViewCell()
//        cell.textLabel?.text = "default text"
//        return cell
//    }
    
    // the functions below are needed for compliance with the CLLocationManagerDelegate:
    
    // This method gets called when the user responds to the permission dialog.
    // If the user chose Allow, the status becomes CLAuthorizationStatus.authorizedWhenInUse.
    // We also trigger another requestLocation() because the first attempt would have suffered a permission failure.
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        if status == .authorizedWhenInUse {
//            locationManager.requestLocation()
//        }
//    }

    // This gets called when location information comes back.
    // We get an array of locations.
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//
//        if let location = locations.first {
//            let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
//            let region = MKCoordinateRegion(center: location.coordinate, span: span)
//            // mapView.setRegion(region, animated: true)
//        }
//    }
//
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print("error:: (error)")
//    }
}


