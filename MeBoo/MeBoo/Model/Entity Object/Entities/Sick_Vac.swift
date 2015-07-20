//
//  Sick_Vac.swift
//  MeBoo
//
//  Created by Nam Phong on 7/17/15.
//  Copyright (c) 2015 Phong Nguyen Nam. All rights reserved.
//

import Foundation
import CoreData
@objc(Sick_Vac)
class Sick_Vac: NSManagedObject {

    @NSManaged var sid: NSNumber
    @NSManaged var vaccine: String

}
