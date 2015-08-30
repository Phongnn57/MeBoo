//
//  Injection_Schedule.swift
//  MeBoo
//
//  Created by Nam Phong Nguyen on 8/5/15.
//  Copyright (c) 2015 Nam Phong. All rights reserved.
//

import Foundation
import CoreData
@objc(Injection_Schedule)
class Injection_Schedule: NSManagedObject {

    @NSManaged var id: NSNumber
    @NSManaged var month: NSNumber
    @NSManaged var number: NSNumber
    @NSManaged var sickID: NSNumber

}
