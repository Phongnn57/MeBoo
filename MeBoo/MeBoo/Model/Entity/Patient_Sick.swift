//
//  Patient_Sick.swift
//  MeBoo
//
//  Created by Nam Phong Nguyen on 8/5/15.
//  Copyright (c) 2015 Nam Phong. All rights reserved.
//

import Foundation
import CoreData
@objc(Patient_Sick)
class Patient_Sick: NSManagedObject {

    @NSManaged var id: NSNumber
    @NSManaged var patientID: NSNumber
    @NSManaged var sickID: NSNumber

}
