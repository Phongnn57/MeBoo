//
//  Sick.swift
//  MeBoo
//
//  Created by Nam Phong Nguyen on 8/5/15.
//  Copyright (c) 2015 Nam Phong. All rights reserved.
//

import Foundation
import CoreData
@objc(Sick)
class Sick: NSManagedObject {

    @NSManaged var count: NSNumber
    @NSManaged var descrip: String
    @NSManaged var gender: NSNumber
    @NSManaged var id: NSNumber
    @NSManaged var sickCode: String
    @NSManaged var sickName: String

}
