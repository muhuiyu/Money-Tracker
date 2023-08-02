//
//  AppDelegate.swift
//  Money Tracker
//
//  Created by Grace, Mu-Hui Yu on 7/30/23.
//

import UIKit
import UserNotifications

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
        
        // Request authorization for notifications
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            if granted {
                DispatchQueue.main.async {
                    // Register for remote notifications
                    application.registerForRemoteNotifications()
                    
                    // Configure notification settings
                    let notificationCenter = UNUserNotificationCenter.current()
                    notificationCenter.delegate = self // Set your app delegate as the notification center delegate
                    
                    // Configure the notification categories and options
                    // ...
                    
                    // Request authorization for features like provisional authorization or critical alerts
                    // ...
                    
                    // Update UI or perform other actions as needed
                    // ...
                }
            } else {
                // Handle if user denies permission
            }
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

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let content = response.notification.request.content
        let notificationBody = content.body
        let notificationTitle = content.title
        
        print("Received notification:")
        print("Title: \(notificationTitle)")
        print("Body: \(notificationBody)")
        
        // Handle the notification as needed
        
        completionHandler()
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
         let token = deviceToken.map { String(format: "%.2hhx", $0) }.joined()
         print("Device Token: \(token)")
       
         // Send the device token to your server for further processing if required.
     }

     func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
         print("Failed to register for remote notifications: \(error)")
     }

     func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
         if let aps = userInfo["aps"] as? [String: Any] {
             // Extract notification content, title, etc. from the 'aps' dictionary
             let notificationBody = aps["alert"] as? String

             print("Received remote notification:")
             print("Body: \(notificationBody ?? "")")
         }

         // Handle the received remote notification as needed

         completionHandler(.newData)
     }
}
