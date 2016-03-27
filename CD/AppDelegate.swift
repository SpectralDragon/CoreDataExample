//
//  AppDelegate.swift
//  CoreData Example
//
//  Created by Vladislav on 24.03.16.
//  Copyright © 2016 Vladislav Prusakov. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        //NavigationBar settings
        UINavigationBar.appearance().barTintColor = UIColor(red: 2/255.0, green: 17/255.0, blue: 37/255.0, alpha: 1.0)
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        UINavigationBar.appearance().translucent = false
        UINavigationBar.appearance().barStyle = UIBarStyle.Black
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        return true
    }
}

