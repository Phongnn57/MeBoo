//
//  Biography_Statistic.swift
//  MeBoo
//
//  Created by Nam Phong Nguyen on 8/5/15.
//  Copyright (c) 2015 Nam Phong. All rights reserved.
//

import Foundation
import CoreData
@objc(Biography_Statistic)
class Biography_Statistic: NSManagedObject {

    @NSManaged var height: NSNumber
    @NSManaged var id: NSNumber
    @NSManaged var lastUpdated: NSNumber
    @NSManaged var timestamp: String
    @NSManaged var weight: NSNumber
    @NSManaged var patientID: NSNumber

}
