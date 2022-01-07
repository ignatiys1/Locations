//
//  AppDelegate.swift
//  Locations
//
//  Created by Ignat Urbanovich on 3.01.22.
//

import UIKit
import Firebase



@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        window?.rootViewController = ViewController()
        window?.makeKeyAndVisible()
        
        
        return true
    }
    
}

