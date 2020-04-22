//
//  AppDelegate.swift
//  Assignment2
//
//  Created by 김현석 on 2020/04/06.
//  Copyright © 2020 urbanGY. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
////        let viewController = appDelegate.window?.rootViewController as! ViewController
//
//        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
//        let items = urlComponents?.queryItems
//
//        let key = items?.first?.name
//        let value = items?.first?.value
//
//        NoticeData.key = key!
//        NoticeData.value = value!
//
//
//        var result = [String:String]()
//        result["key"] = key
//        result["value"] = value
//
////        viewController.sendID = "왜 안되는 것이지?"
//
//        NotificationCenter.default.post(name: NSNotification.Name("setResult"), object: result)

        return true
    }

    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSCustomPersistentContainer(name: "Memo") // 여기는 파일명을 적어줘요.
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
                fatalError("Unresolved error, \((error as NSError).userInfo)")
            }
        })
        return container
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
    
//    func applicationDidFinishLaunching(_ application: UIApplication) {
//        return
//    }

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

