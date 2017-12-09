//
//  AppDelegate.swift
//  MesActivites
//
//  Created by Nicolas Salleron on 08/11/2017.
//  Copyright © 2017 Nicolas Salleron. All rights reserved.
//

import UIKit

enum terminalType {
    case undefined
    case iphone35
    case iphone40
    case iphone47
    case iphone55
    case ipad
    case ipadpro
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        var monterminal = terminalType.undefined
        if UIDevice.current.userInterfaceIdiom == .phone &&
            UIScreen.main.bounds.size.height < 568 {
            monterminal = terminalType.iphone35
        } else if UIDevice.current.userInterfaceIdiom == .phone &&
            UIScreen.main.bounds.size.height == 568 {
            monterminal = terminalType.iphone40
        } else if UIDevice.current.userInterfaceIdiom == .phone &&
            UIScreen.main.bounds.size.height == 667 {
            monterminal = terminalType.iphone47
        } else if UIDevice.current.userInterfaceIdiom == .phone &&
            UIScreen.main.bounds.size.height == 736 {
                monterminal = terminalType.iphone55
        } else if UIDevice.current.userInterfaceIdiom == .pad &&
            UIScreen.main.bounds.size.height == 1024 {
            monterminal = terminalType.ipad
        } else if UIDevice.current.userInterfaceIdiom == .pad &&
            UIScreen.main.bounds.size.height == 1366 {
            monterminal = terminalType.ipadpro
        }
        
        let svc = UISplitViewController()
        let mvc = MasterViewController(style: .plain)
        let mnvc = UINavigationController(rootViewController: mvc)
        let dvc = DetailViewController()
        let dnvc = UINavigationController(rootViewController: dvc)
        
        
        /* Pour la communication dans les deux sens */
        mvc.svc = svc
        mvc.termType = monterminal
        mvc.dvc = dvc
        mvc.mnvc = mnvc
        
        
        dvc.svc = svc
        dvc.termType = monterminal
        dvc.mvc = mvc
        
        svc.viewControllers = [mnvc,dnvc]
        svc.delegate = mvc
        
        switch monterminal {
        case .iphone35, .iphone40, .iphone47, .iphone55:
            svc.preferredDisplayMode = .automatic
            mvc.mobile = true
        default:
            svc.preferredDisplayMode = .allVisible
        }
        
        window?.rootViewController = svc
        
        /*  Each UIWindow has a windowLevel. A window is displayed in front of each window with a lower level, and behind each window with a higher level.
 
            But what about two windows with the same level? The window whose level was set more recently is in front, by default. (“When a window enters a new level, it’s ordered in front of all its peers in that level.”) The makeKeyWindow message makes a window key, but that window might be partially or completely hidden behind another window on the same level. The makeKeyAndVisible message makes a window key, and moves it to be in front of any other windows on its level.
            Source : https://stackoverflow.com/questions/25260290/makekeywindow-vs-makekeyandvisible
         */
        
        window?.makeKeyAndVisible()

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
    }


}

