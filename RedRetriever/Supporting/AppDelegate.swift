//
//  AppDelegate.swift
//  A4
//
//  Created by Vin Bui on 10/31/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    

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


class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create instances of your view controllers
        let homeVC = HomeVC()
        let requestsVC = RequestsVC()
        
        // Set titles and images for the tabs
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        requestsVC.tabBarItem = UITabBarItem(title: "Requests", image: UIImage(systemName: "questionmark.circle"), tag: 1)
        
        // Set up the view controllers for the tab bar controller
        self.viewControllers = [homeVC, requestsVC]
        
        // Optionally, customize the appearance of the tab bar
        self.tabBar.barTintColor = UIColor.white
        self.tabBar.tintColor = UIColor.systemBlue
    }
}
