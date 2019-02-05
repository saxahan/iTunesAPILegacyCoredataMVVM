//
//  AppDelegate.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 4.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        initTools(application, didFinishLaunchingWithOptions: launchOptions)
        setupRootViewController()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        CoreDataStack.saveContext()
    }

    // MARK - Initializers

    func initTools(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) {
        // enviroment
        AppConfig.configure()

        // reachability
//        try? Reachability(hostname: AppConfig.baseURL.absoluteString)?.start()
    }

    func setupRootViewController(_ vc: UIViewController? = nil) {
        if window == nil {
            window = UIWindow(frame: UIScreen.main.bounds)
        }

        if let rootVc = vc {
            window?.rootViewController = rootVc
        }
        else {
            window?.rootViewController = SplashViewController.instantiate()
        }

        window?.makeKeyAndVisible()
    }

    func startTabBased() {
//        let searchVc = MediaSearchViewController.instantiate(with: MediaSearchViewModel())
        let searchVc = MediaSearchViewController.instantiate(with: MediaSearchViewModel(), title: "Search", tabImage: #imageLiteral(resourceName: "search"))
        let settingsVc = SettingsViewController.instantiate(with: MediaSearchViewModel(), title: "Settings", tabImage: #imageLiteral(resourceName: "settings"))
        let tabVc = TabController.createTabBased([searchVc, settingsVc])

        setupRootViewController(tabVc)
    }
}

