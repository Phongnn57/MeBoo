//
//  Biography_Statistic.swift
//  MeBoo
//
//  Created by Nam Phong on 7/17/15.
//  Copyright (c) 2015 Phong Nguyen Nam. All rights reserved.
//

import Foundation
import CoreData
@objc(Biography_Statistic)
class Biography_Statistic: NSManagedObject {

    @NSManaged var height: NSNumber
    @NSManaged var lastUpdated: NSNumber
    @NSManaged var weight: NSNumber
    @NSManaged var timestamp: String

}
