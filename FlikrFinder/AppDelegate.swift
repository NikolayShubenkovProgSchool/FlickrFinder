//
//  AppDelegate.swift
//  FlikrFinder
//
//  Created by Andrey on 14.02.16.
//  Copyright © 2016 Andrey. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool
    {
        UINavigationBar.appearance().barTintColor = UIColor.orangeColor()
//            ..UIColor(red: 201 / 255, green: 81 / 255, blue: 0 / 255, alpha: 1.0)
        
        if let font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 22) {
            UINavigationBar.appearance().tintColor = UIColor.whiteColor()
            UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: font]
        }

        UISearchBar.appearance().barTintColor = UIColor.orangeColor()
        UISearchBar.appearance().tintColor = UIColor.whiteColor()
        UITabBar.appearance().barTintColor = UIColor.orangeColor()
        UITabBar.appearance().tintColor = UIColor.whiteColor()

        UITextField.appearanceWhenContainedInInstancesOfClasses([UISearchBar.self]).tintColor = UIColor.orangeColor()

        return true
    }
}
