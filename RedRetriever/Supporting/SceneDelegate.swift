//
//  SceneDelegate.swift
//  A4
//
//  Created by Vin Bui on 10/31/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // 1. Capture the scene
        guard let windowScene = (scene as? UIWindowScene) else { return }

        // Create the UIWindow
        let window = UIWindow(windowScene: windowScene)

        // Check user login state
        let isUserLoggedIn = UserDefaults.standard.bool(forKey: "isUserLoggedIn")
        let initialViewController: UIViewController

        if isUserLoggedIn {
            // User is logged in, show HomeVC
//            initialViewController = HomeVC()
            initialViewController = MainTabBarController()
        } else {
            // User is not logged in, show LoginVC
            initialViewController = LoginVC()
        }

        // Set the root view controller
        window.rootViewController = UINavigationController(rootViewController: initialViewController)

        self.window = window
        window.makeKeyAndVisible()
        
        
//        // 2. Create a new UIWindow and pass in a UIWindowScene
//        let window = UIWindow(windowScene: windowScene)
//
//        // 3. Create a view hierarchy programmatically
//        let rootVC = LoginVC()
//        let navController = UINavigationController(rootViewController: rootVC)
//        let tabBarController = MainTabBarController()
//        
//        // 4. Set the navigation controller as the window's root view controller
//        window.rootViewController = navController
//
//        // 5. Set the window and call makeKeyAndVisible()
//        self.window = window
//        window.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }

}
