//
//  AppDelegate.swift
//  A4
//
//  Created by Vin Bui on 10/31/23.
//

import UIKit
import GoogleSignIn
import GoogleSignInSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    var isDataFetched = false

    static var shared: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Initialize Google Sign-In
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            if let error = error {
                print("Error restoring sign-in: \(error.localizedDescription)")
            } else {
                print("User restored: \(String(describing: user?.profile?.name))")
                let emailAddress = user?.profile?.email
                let fullName = user?.profile?.name
                let givenName = user?.profile?.givenName
                let familyName = user?.profile?.familyName
                let profilePicUrl = user?.profile?.imageURL(withDimension: 320)
                UserManager.shared.email = emailAddress
                UserManager.shared.profileName = fullName
                UserManager.shared.firstName = givenName
                UserManager.shared.lastName = familyName
                UserManager.shared.profilePicURL = profilePicUrl
                
                let dispatchGroup = DispatchGroup()
                
                DispatchQueue.global().async {
                    // Start the first API call
                    dispatchGroup.enter()
                    NetworkManager.shared.fetchAllPosts { [weak self] requests in
                        defer { dispatchGroup.leave() }
                        guard let self = self else { return }
                        UserManager.shared.requests = requests
                        if let requests = UserManager.shared.requests {
                            for request in requests {
                                print(request.location, request.description, request.name, request.status)
                            }
                        } else {
                            print("No requests to process")
                        }
                        print(UserManager.shared.requests?.count ?? 0)
                    }
                    
                    // Start the second API call
                    dispatchGroup.enter()
                    NetworkManager.shared.fetchAllItems { [weak self] items in
                        defer { dispatchGroup.leave() }
                        guard let self = self else { return }
                        UserManager.shared.items = items
                        if let items = UserManager.shared.items {
                            for item in items {
                                print(item.location, item.description, item.title, item.status, item.image)
                            }
                        } else {
                            print("No items to process")
                        }
                        print(UserManager.shared.items?.count ?? 0)
                    }
                    
                    // Start the third API call
                    dispatchGroup.enter()
                    NetworkManager.shared.fetchAllUsers { [weak self] users in
                        defer { dispatchGroup.leave() }
                        guard let self = self else { return }
                        UserManager.shared.users = users
                        if let users = UserManager.shared.users {
                            for user in users {
                                print(user.name, user.email, user.points)
                            }
                        } else {
                            print("No user to process")
                        }
                        print(UserManager.shared.users?.count ?? 0)
                        for user in users {
                            if UserManager.shared.email == user.email {
                                UserManager.shared.userID = user.id
                                UserManager.shared.points = user.points
//                                UserManager.shared.requests = user.requests
                                print("user found!!")
                            }
                        }
                    }
                    
                    // Notify once all API calls are completed
                    dispatchGroup.notify(queue: .main) { [weak self] in
                        guard let self = self else { return }
                        print(UserManager.shared.requests?.count)
                        print("All API calls completed")
                        self.isDataFetched = true
                        
                        // Post a notification
                        NotificationCenter.default.post(name: .dataFetched, object: nil)
                    }
                }
            }
            
        }
        return true
    }
    }
    
    func application(
            _ app: UIApplication,
            open url: URL,
            options: [UIApplication.OpenURLOptionsKey : Any] = [:]
        ) -> Bool {
            return GIDSignIn.sharedInstance.handle(url)
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




class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("Current Tab Bar Item Title: \(self.tabBarItem.title ?? "No Title")")
    }
    
    override func viewDidLoad() {
            super.viewDidLoad()
            
            self.setupTabs()
            
    //        self.selectedIndex = 0
            
            self.tabBar.barTintColor = UIColor.a4.white
            self.tabBar.tintColor = UIColor.a4.ruby
            self.tabBar.unselectedItemTintColor = .black
        
        self.delegate = self
            
        }
        
        // MARK: - Tab Setup
        private func setupTabs() {
            let home = self.createNav(with: "Home", and: UIImage(systemName: "house"), vc: HomeVC())
            let tickets = self.createNav(with: "Requests", and: UIImage(systemName: "envelope.badge"), vc: RequestsVC())
            let profile = self.createNav(with: "Profile", and: UIImage(systemName: "person.crop.circle"), vc: ProfileVC())
            
            self.setViewControllers([home, tickets, profile], animated: true)
        }
        
        private func createNav(with title: String, and image: UIImage?, vc: UIViewController) -> UINavigationController {
            let nav = UINavigationController(rootViewController: vc)
            
            nav.tabBarItem.title = title
            nav.tabBarItem.image = image
            
    //        nav.viewControllers.first?.navigationItem.title = title + " Controller"
    //
    //        nav.viewControllers.first?.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Button", style: .plain, target: nil, action: nil)
            
            return nav
        }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
            print("Switched to tab with title: \(viewController.tabBarItem.title ?? "No Title")")
        }
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        // Create instances of your view controllers
//        let homeVC = HomeVC()
//        let requestsVC = RequestsVC()
//        
//        // Set titles and images for the tabs
//        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
//        requestsVC.tabBarItem = UITabBarItem(title: "Requests", image: UIImage(systemName: "questionmark.circle"), tag: 1)
//        
//        // Set up the view controllers for the tab bar controller
//        self.viewControllers = [homeVC, requestsVC]
//        
//        // Optionally, customize the appearance of the tab bar
//        self.tabBar.barTintColor = UIColor.white
//        self.tabBar.tintColor = UIColor.systemBlue
//    }
}

extension Notification.Name {
    static let dataFetched = Notification.Name("dataFetched")
}
