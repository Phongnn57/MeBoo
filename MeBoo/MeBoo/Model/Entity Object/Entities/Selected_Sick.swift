//
//  Selected_Sick.swift
//  MeBoo
//
//  Created by Nam Phong on 7/17/15.
//  Copyright (c) 2015 Phong Nguyen Nam. All rights reserved.
//

import Foundation
import CoreData
@objc(Selected_Sick)
class Selected_Sick: NSManagedObject {

    @NSManaged var patientID: NSNumber
    @NSManaged var sickID: NSNumber

}
