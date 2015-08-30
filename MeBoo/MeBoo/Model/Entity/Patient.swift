//
//  Patient.swift
//  MeBoo
//
//  Created by Nam Phong Nguyen on 8/9/15.
//  Copyright (c) 2015 Nam Phong. All rights reserved.
//

import Foundation
import CoreData
@objc(Patient)
class Patient: NSManagedObject {

    @NSManaged var bloodType: String
    @NSManaged var dob: NSDate
    @NSManaged var gender: NSNumber
    @NSManaged var id: NSNumber
    @NSManaged var lastUpdated: NSNumber
    @NSManaged var name: String
    @NSManaged var photo: String
    @NSManaged var relationshipWithUser: String
    @NSManaged var userId: NSNumber

}
