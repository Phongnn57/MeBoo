//
//  Pharmacy.swift
//  MeBoo
//
//  Created by Nam Phong on 7/17/15.
//  Copyright (c) 2015 Phong Nguyen Nam. All rights reserved.
//

import Foundation
import CoreData

@objc(Pharmacy)
class Pharmacy: NSManagedObject {

    @NSManaged var latitude: NSNumber
    @NSManaged var longitude: NSNumber
    @NSManaged var address: String
    @NSManaged var contactNumber: String
    @NSManaged var name: String
    @NSManaged var state: String

}
