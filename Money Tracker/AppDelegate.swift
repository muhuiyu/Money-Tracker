//
//  AppDelegate.swift
//  Money Tracker
//
//  Created by Grace, Mu-Hui Yu on 7/30/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    enum ApplicationShortcutItemType: String {
        case add = "QuickAction.Add"
        case search     = "QuickAction.Search"
    }

    enum ApplicationShortcutItemTitle: String {
        case add        = "Add"
        case search     = "Search"
    }

    var launchedShortcutItem: UIApplicationShortcutItem?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
                
        // If the app is launched by Quick Action, then take the relevant action
        if let shortcutItem = launchOptions?[UIApplication.LaunchOptionsKey.shortcutItem] as? UIApplicationShortcutItem {
            
            launchedShortcutItem = shortcutItem
            
            // Since, the app launch is triggered by QuicAction, block "performActionForShortcutItem:completionHandler" method from being called.
            return false
        }
        return true
    }
    
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        guard let actionType = ApplicationShortcutItemType(rawValue: shortcutItem.type) else { return }
        
        switch actionType {
        case .search:
            print("Handle search action")
        case .add:
            print("Handle add action")
        }
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
