//
//  GlobalConstant.swift
//  Sổ Y Bạ
//
//  Created by Nam Phong on 7/16/15.
//  Copyright (c) 2015 Phong Nguyen Nam. All rights reserved.
//

import Foundation
import UIKit

let DELEGATE: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
let SCREEN_SIZE: CGSize = UIScreen.mainScreen().bounds.size
let DEVICE_VERSION = (UIDevice.currentDevice().systemVersion as NSString).floatValue
let SCARE_SCREEN: CGFloat = SCREEN_SIZE.width / 375.0
let NOTIFICATION_CENTER: NSNotificationCenter = NSNotificationCenter.defaultCenter()
let USER_DEFAULT: NSUserDefaults = NSUserDefaults.standardUserDefaults()

struct AppConstant {
    struct Fonts {
        
    }
    
    struct Notifications {
        
    }
    
    struct UserDefault {
        static let UserObject: String = "UserObject"
    }
    
    struct API {
        struct URLs {
            static let BaseURL: String = ""
            
        }
        
        struct KEYs {
            
        }
    }
}