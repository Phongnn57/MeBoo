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
        
        UserObject.readOffline()
        MagicalRecord.setupCoreDataStack()
        
        GPPSignIn.sharedInstance().clientID = kClientId
        GPPSignIn.sharedInstance().scopes = [kGTLAuthScopePlusLogin]
        GPPSignIn.sharedInstance().shouldFetchGoogleUserID = true
        GPPSignIn.sharedInstance().shouldFetchGoogleUserEmail = true
        GPPSignIn.sharedInstance().shouldFetchGooglePlusUser = true
        GPPSignIn.sharedInstance().trySilentAuthentication()
        
        if self.isFirstRun() {
            self.preloadData()
        }
        
        let loginViewController = LoginViewController()
        self.window?.rootViewController = loginViewController
//        MagicalRecord 
//        self.startApp()
        return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
//        return true
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
        FBSDKAppEvents.activateApp()
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation) || GPPURLHandler.handleURL(url, sourceApplication: sourceApplication, annotation: annotation)
    }
    
    func isFirstRun() -> Bool {
        if !USER_DEFAULT.boolForKey("firstRun") {
            USER_DEFAULT.setBool(true, forKey: "firstRun")
            return true
        } else{
            return false
        }
    }
    
    func changeRootViewController(viewController: UIViewController) {
        if !(self.window?.rootViewController != nil) {
            self.window?.rootViewController = viewController
            return
        }
        
        let snapShot = self.window?.snapshotViewAfterScreenUpdates(true)
        viewController.view.addSubview(snapShot!)
        self.window?.rootViewController = viewController
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            snapShot?.layer.opacity = 0
            snapShot?.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1.5)
            }) { (finished: Bool) -> Void in
                snapShot?.removeFromSuperview()
        }
    }

    func startApp() {
        let sections:NSMutableArray = NSMutableArray()
        
        var firstSection: [AnyObject] = []
        var secondSection: [AnyObject] = []
        var thirdSection: [AnyObject] = []
        var fourthSection: [AnyObject] = []
        
        firstSection.append(UINavigationController(rootViewController: HomeViewController()))
        secondSection.append(UINavigationController(rootViewController: ClinicViewController()))
        secondSection.append(UINavigationController(rootViewController: MedicalStationViewController()))
        thirdSection.append(UINavigationController(rootViewController: MemberManagerViewController()))
        fourthSection.append(UINavigationController(rootViewController: AppInfoViewController()))
        fourthSection.append(UINavigationController(rootViewController: SettingViewController()))
        
        sections.addObject(firstSection)
        sections.addObject(secondSection)
        sections.addObject(thirdSection)
        sections.addObject(fourthSection)
        
        let frontViewController: UIViewController = firstSection.first as! UIViewController
        
        self.menuViewController = MenuController()
        self.menuViewController.sections = sections
        
        let revealController: SWRevealViewController = SWRevealViewController(rearViewController: self.menuViewController, frontViewController: frontViewController)
        revealController.delegate = self
        
        revealController.frontViewShadowRadius = 5.0;
        revealController.frontViewShadowOffset = CGSizeMake(0.0, 5.0);
        revealController.frontViewShadowOpacity = 0.125;
        revealController.frontViewShadowColor = UIColor.grayColor()
        
        self.changeRootViewController(revealController)
    }
    
    // MARK: COREDATA PRELOAD
    
    func parseMedicalStation(contentsOfURL: NSURL, encoding: NSStringEncoding, error: NSErrorPointer, entity: Int) {
        let delimiter = ","
        if let content = String(contentsOfURL: contentsOfURL, encoding: encoding, error: error) {
            let lines:[String] = content.componentsSeparatedByCharactersInSet(NSCharacterSet.newlineCharacterSet()) as [String]
            
            for line in lines {
                var values:[String] = []
                if line != "" {
                    // For a line with double quotes
                    // we use NSScanner to perform the parsing
                    if line.rangeOfString("\"") != nil {
                        var textToScan:String = line
                        var value:NSString?
                        var textScanner:NSScanner = NSScanner(string: textToScan)
                        while textScanner.string != "" {
                            
                            if (textScanner.string as NSString).substringToIndex(1) == "\"" {
                                textScanner.scanLocation += 1
                                textScanner.scanUpToString("\"", intoString: &value)
                                textScanner.scanLocation += 1
                            } else {
                                textScanner.scanUpToString(delimiter, intoString: &value)
                            }
                            
                            // Store the value into the values array
                            values.append(value as! String)
                            
                            // Retrieve the unscanned remainder of the string
                            if textScanner.scanLocation < count(textScanner.string) {
                                textToScan = (textScanner.string as NSString).substringFromIndex(textScanner.scanLocation + 1)
                            } else {
                                textToScan = ""
                            }
                            textScanner = NSScanner(string: textToScan)
                        }
                        
                        // For a line without double quotes, we can simply separate the string
                        // by using the delimiter (e.g. comma)
                    } else  {
                        values = line.componentsSeparatedByString(delimiter)
                    }
                    
                    if entity == AppConstant.Entities.Pharmacy {
                        var pharmarcy = Clinic.createEntity() as! Clinic
                        pharmarcy.id = values[0].toInt()! ?? 0
                        pharmarcy.name = values[1]
                        pharmarcy.address = values[2]
                        pharmarcy.longitude = values[3].toFloat()! ?? 0
                        pharmarcy.latitude = values[4].toFloat()! ?? 0
                        pharmarcy.state = values[5]
                        pharmarcy.contactNumber = values[6]
                    } else if entity == AppConstant.Entities.Sick {
                        var sick = Sick.createEntity() as! Sick
                        sick.id = values[0].toInt()! ?? 0
                        sick.sickName = values[1]
                        sick.descrip = values[2]
                        sick.gender = values[3].toInt()! ?? 0
                        sick.sickCode = values[4]
                        sick.count = values[5].toInt()! ?? 0
                        
                        NSManagedObjectContext.defaultContext().saveToPersistentStoreAndWait()
                    } else if entity == AppConstant.Entities.InjectionSchedule {
                        var injectionSchedule = Injection_Schedule.createEntity() as! Injection_Schedule
                        
                        injectionSchedule.id = values[0].toInt()!
                        injectionSchedule.sickID = values[1].toInt()!
                        injectionSchedule.month = values[2].toInt()!
                        injectionSchedule.number = values[3].toInt()!
                    }
                    // Put the values into the tuple and add it to the items array

                }
            }
        }
    }
    
    func preloadData () {
        // Retrieve data from the source file
        if let contentsOfURL = NSBundle.mainBundle().URLForResource("Clinic", withExtension: "csv") {
            var error:NSError?

            self.parseMedicalStation(contentsOfURL, encoding: NSUTF8StringEncoding, error: &error, entity: AppConstant.Entities.Pharmacy)
        }
        if let contentsOfURL = NSBundle.mainBundle().URLForResource("Sick", withExtension: "csv") {
            var error:NSError?
            
            self.parseMedicalStation(contentsOfURL, encoding: NSUTF8StringEncoding, error: &error, entity: AppConstant.Entities.Sick)
        }
        
        if let contentsOfURL = NSBundle.mainBundle().URLForResource("InjectionSchedule", withExtension: "csv") {
            var error:NSError?
            
            self.parseMedicalStation(contentsOfURL, encoding: NSUTF8StringEncoding, error: &error, entity: AppConstant.Entities.InjectionSchedule)
        }
        
        let items = Sick.MR_findAll() as! [Sick]
        print(items.count)
    }
}

