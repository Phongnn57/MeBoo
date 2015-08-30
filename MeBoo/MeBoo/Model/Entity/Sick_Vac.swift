//
//  Sick_Vac.swift
//  MeBoo
//
//  Created by Nam Phong Nguyen on 8/5/15.
//  Copyright (c) 2015 Nam Phong. All rights reserved.
//

import Foundation
import CoreData
@objc(Sick_Vac)
class Sick_Vac: NSManagedObject {

    @NSManaged var id: NSNumber
    @NSManaged var sid: NSNumber
    @NSManaged var vaccine: String

}
