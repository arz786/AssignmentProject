//
//  AppDelegate.swift
//  ClientAssignment
//
//  Created by Arzu Mozammil on 08/01/2026.
//

import UIKit
import RealmSwift
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //  Initialize window
            window = UIWindow(frame: UIScreen.main.bounds)

            // Realm session check
            let realm = try! Realm()
            let session = realm.object(ofType: LoginSession.self, forPrimaryKey: 0)

            //  Determine initial VC
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let rootVC: UIViewController

            if session?.isLoggedIn == true {
                // User is logged in → show MainTabBarController
                rootVC = storyboard.instantiateViewController(
                    withIdentifier: "MainTabBarController"
                )
            } else {
                // Not logged in → show LoginViewController
                rootVC = storyboard.instantiateViewController(
                    withIdentifier: "LoginViewController"
                )
            }

            // 4️⃣ Embed in navigation controller
            let nav = UINavigationController(rootViewController: rootVC)
            window?.rootViewController = nav
            window?.makeKeyAndVisible()
      return true
    }

  

   

}

