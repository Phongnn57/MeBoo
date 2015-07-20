//
//  Sick.swift
//  MeBoo
//
//  Created by Nam Phong on 7/17/15.
//  Copyright (c) 2015 Phong Nguyen Nam. All rights reserved.
//

import Foundation
import CoreData
@objc(Sick)
class Sick: NSManagedObject {

    @NSManaged var count: NSNumber
    @NSManaged var gender: NSNumber
    @NSManaged var descrip: String
    @NSManaged var sickCode: String
    @NSManaged var sickName: String
    
}
