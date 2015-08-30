//
//  Patient_Injection.swift
//  MeBoo
//
//  Created by Nam Phong Nguyen on 8/9/15.
//  Copyright (c) 2015 Nam Phong. All rights reserved.
//

import Foundation
import CoreData
@objc(Patient_Injection)
class Patient_Injection: NSManagedObject {

    @NSManaged var id: NSNumber
    @NSManaged var injectDay: NSDate
    @NSManaged var isDone: NSNumber
    @NSManaged var lastUpdated: NSNumber
    @NSManaged var month: NSNumber
    @NSManaged var note: String
    @NSManaged var number: NSNumber
    @NSManaged var patientID: NSNumber
    @NSManaged var sickID: NSNumber
    @NSManaged var vacName: String
}
