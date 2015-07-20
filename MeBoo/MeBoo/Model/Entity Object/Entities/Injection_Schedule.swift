//
//  Injection_Schedule.swift
//  MeBoo
//
//  Created by Nam Phong on 7/17/15.
//  Copyright (c) 2015 Phong Nguyen Nam. All rights reserved.
//

import Foundation
import CoreData
@objc(Injection_Schedule)
class Injection_Schedule: NSManagedObject {

    @NSManaged var month: NSNumber
    @NSManaged var number: NSNumber
    @NSManaged var sickID: NSNumber

}
