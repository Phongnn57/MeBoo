//
//  Patient.swift
//  MeBoo
//
//  Created by Nam Phong on 7/17/15.
//  Copyright (c) 2015 Phong Nguyen Nam. All rights reserved.
//

import Foundation
import CoreData
@objc(Patient)
class Patient: NSManagedObject {

    @NSManaged var gender: NSNumber
    @NSManaged var lastUpdated: NSNumber
    @NSManaged var userId: NSNumber
    @NSManaged var bloodType: String
    @NSManaged var dob: String
    @NSManaged var name: String
    @NSManaged var photo: String
    @NSManaged var relationshipWithUser: String

}
