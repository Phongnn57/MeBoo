//
//  Patient_Injection.swift
//  MeBoo
//
//  Created by Nam Phong on 7/17/15.
//  Copyright (c) 2015 Phong Nguyen Nam. All rights reserved.
//

import Foundation
import CoreData
@objc(Patient_Injection)
class Patient_Injection: NSManagedObject {

    @NSManaged var done: NSNumber
    @NSManaged var injectDay: NSNumber
    @NSManaged var lastUpdated: NSNumber
    @NSManaged var month: NSNumber
    @NSManaged var number: NSNumber
    @NSManaged var patientID: NSNumber
    @NSManaged var sickID: NSNumber
    @NSManaged var note: String
    @NSManaged var vacName: String

}
