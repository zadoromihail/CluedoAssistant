//
//  AppDelegate.swift
//  CluedoAssistant
//
//  Created by Михаил Задорожный on 07.11.2020.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let vc = StartViewController()
        let nc = UINavigationController(rootViewController: vc)
        window.rootViewController = nc
        window.makeKeyAndVisible()
        self.window = window
        return true
    }
}
