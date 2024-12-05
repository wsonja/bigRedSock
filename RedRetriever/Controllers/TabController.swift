//
//  TabController.swift
//  A4
//
//  Created by Ethan Seiz on 12/3/24.
//

import UIKit

class TabController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTabs()
        
//        self.selectedIndex = 0
        
        self.tabBar.barTintColor = UIColor.a4.white
        self.tabBar.tintColor = UIColor.a4.ruby
        self.tabBar.unselectedItemTintColor = .black
        
    }
    
    // MARK: - Tab Setup
    private func setupTabs() {
        let home = self.createNav(with: "Home", and: UIImage(named: "home"), vc: HomeVC())
        let tickets = self.createNav(with: "Requests", and: UIImage(named: "inbox"), vc: RequestsVC())
        let profile = self.createNav(with: "Profile", and: UIImage(named: "profile"), vc: ProfileVC())
        
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
}
