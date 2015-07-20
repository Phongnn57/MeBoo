//
//  AppDelegate.swift
//  MeBoo
//
//  Created by Nam Phong on 7/19/15.
//  Copyright (c) 2015 Nam Phong. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, SWRevealViewControllerDelegate {

    var window: UIWindow?

    var navigationController: UINavigationController!
    var menuViewController: MenuController!
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        self.window?.makeKeyAndVisible()
        
        
        let loginViewController = LoginViewController()
        self.window?.rootViewController = loginViewController
        
//        self.startApp()
//        return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
//        FBSDKAppEvents.activateApp()
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

//    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
//        return FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation) || GPPURLHandler.handleURL(url, sourceApplication: sourceApplication, annotation: annotation)
//    }
    
    func changeRootViewController(viewController: UIViewController) {
        if !(self.window?.rootViewController != nil) {
            self.window?.rootViewController = viewController
            return
        }
        
        let snapShot = self.window?.snapshotViewAfterScreenUpdates(true)
        viewController.view.addSubview(snapShot!)
        self.window?.rootViewController = viewController
        UIView.animateWithDuration(1, animations: { () -> Void in
            snapShot?.layer.opacity = 0
            snapShot?.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1.5)
            }) { (finished: Bool) -> Void in
                snapShot?.removeFromSuperview()
        }
    }

    func startApp() {
        let sections = NSMutableArray(capacity: 1)
        sections.addObject(UINavigationController(rootViewController: HomeViewController()))
        sections.addObject(UINavigationController(rootViewController: MemberManagerViewController()))
        sections.addObject(UINavigationController(rootViewController: MedicalStationViewController()))
        
        let frontViewController: UIViewController = sections.objectAtIndex(0) as! UIViewController
        
        self.menuViewController = MenuController()
        self.menuViewController.sections = sections
        
        let revealController: SWRevealViewController = SWRevealViewController(rearViewController: self.menuViewController, frontViewController: frontViewController)
        revealController.delegate = self
        
        revealController.frontViewShadowRadius = 5.0;
        revealController.frontViewShadowOffset = CGSizeMake(0.0, 5.0);
        revealController.frontViewShadowOpacity = 0.125;
        revealController.frontViewShadowColor = UIColor.greenColor()
        
        self.changeRootViewController(revealController)
    }
}

