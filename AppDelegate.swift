//
//  AppDelegate.swift
//  Locations
//
//  Created by Ignat Urbanovich on 3.01.22.
//

import UIKit
import Firebase


var images: [UIImageView] = []
var names: [String] = []

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        var id = "\(2)"
        while id.count < 9 {
            id = "0"+id
        }
        FirebaseConnector.shared.setName(docName: id, name: "Гродно")
        
//        DispatchQueue.main.async {
//
//            var i = 1
//            while true {
//                print(names)
//                if !names.isEmpty{
//                    if names[names.count-1] == "STOP_CIRCLE" {
//                        names.remove(at: names.count-1)
//                        break
//                    }
//                }
//
//                var id = "\(i)"
//                while id.count < 9 {
//                    id = "0"+id
//                }
//                FirebaseConnector.shared.getName(docName: id, completion: { name in
//                    if let name = name {
//                        names.append(name)
//                    } else {
//                        names.append("STOP_CIRCLE")
//                        return
//                    }
//                })
//                FirebaseConnector.shared.getImage(imgName: "123", completion: {image in
//                    print(image)
//                })
//                i += 1
//            }
//
//
//
//        }
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        window?.rootViewController = ViewController()
        window?.makeKeyAndVisible()
        
        
        return true
    }

}

