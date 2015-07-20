//
//  UserObject.swift
//  Sổ Y Bạ
//
//  Created by Nam Phong on 7/17/15.
//  Copyright (c) 2015 Phong Nguyen Nam. All rights reserved.
//

import UIKit
import Foundation

class UserObject: NSObject, NSCoding {
    static var sharedUser: UserObject = UserObject()
    
    var name: String = ""
    var email: String = ""
    
    required override init() {
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        if let senderName = aDecoder.decodeObjectForKey("name") as? String {
            self.name = senderName
        }
        if let senderEmail = aDecoder.decodeObjectForKey("email") as? String {
            self.email = senderEmail
        }
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.name, forKey: "name")
        aCoder.encodeObject(self.email, forKey: "email")
    }
    
    func saveOffline() {
        NSKeyedArchiver.archiveRootObject(self, toFile: UserObject.fileLocation())
    }
    
    class func readOffline() {
        if let data: AnyObject = NSKeyedUnarchiver.unarchiveObjectWithFile(UserObject.fileLocation()){
            UserObject.sharedUser = (data as? UserObject) ?? UserObject()
        }
    }
    
    private class func fileLocation() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentDirectory = paths[0] as! String
        return documentDirectory.stringByAppendingPathComponent(AppConstant.UserDefault.UserObject)
    }
}