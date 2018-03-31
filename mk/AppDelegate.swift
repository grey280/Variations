//
//  AppDelegate.swift
//  mk
//
//  Created by Grey Patterson on 2018-01-19.
//  Copyright © 2018 Grey Patterson. All rights reserved.
//

import UIKit

/// The AppDelegate! It's important, I assume.
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    /// the window
    var window: UIWindow?


    /// Override point for customization after application launch
    ///
    /// - Parameters:
    ///   - application: the UIApplication instance
    ///   - launchOptions: any launch options you want to throw at it
    /// - Returns: true
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    /// Handle if the application is going to move to background. Hint: not doing anything here.
    ///
    /// - Parameter application: the UIApplication instance
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    /// Handle if the application went into the background. Hint: not doing anything here.
    ///
    /// - Parameter application: the UIApplication instance
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    /// Handle if the application will resume from background. Hint: not doing anything here
    ///
    /// - Parameter application: the UIApplication instance
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    /// Handle if the application is resuming from background. Hint: not doing anything here.
    ///
    /// - Parameter application: the UIApplication instance
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    /// Handle if the application is going to terminate. Hint: not doing anything here
    ///
    /// - Parameter application: the UIApplication instance
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

