//
//  AppDelegate.swift
//  Party Supplies
//
//  Created by Eduardo Antonini on 11/3/20.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    
    // Don't forget to install Parse pods!
    import Parse

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        // --- Copy this only
        
        let parseConfig = ParseClientConfiguration {
                $0.applicationId = "QLiLmn5DwzaODpkHsYMdQD1y0tDcQ9pmFMabQ6VA" // <- UPDATE
                $0.clientKey = "SaiDBa2Oc4jSl33Vs5Uw5oGD0BMjPtIcNBZ1o2gj" // <- UPDATE
                $0.server = "https://parseapi.back4app.com"
        }
        Parse.initialize(with: parseConfig)
        /*  if PFUser.current() != nil {
              let main = UIStoryboard(name: "Main", bundle: nil)
              let feedNavigationController = main.instantiateViewController(withIdentifier: "FeedNavigationController")
              window?.rootViewController = feedNavigationController
          }
        */
        return true
    }
    
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

