//
//  AppDelegate.swift
//  KinjalGitRepositories
//
//  Created by Kinjal panchal on 06/06/24.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

 var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        redirectToRepositories()
        return true
    }
    
    //MARK: Navigate to Repositories list
    func redirectToRepositories() {
        let repositoriesVC = RepositoriesViewController.instantiate(appStoryboard: .Repositories)
        let navigationController = UINavigationController(rootViewController: repositoriesVC)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

}

