//
//  GnomeEntity+CoreDataProperties.swift
//  exercise2Kavak
//
//  Created by Flink on 12/9/19.
//  Copyright © 2019 Andres. All rights reserved.
//
//

import Foundation
import CoreData


extension GnomeEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GnomeEntity> {
        return NSFetchRequest<GnomeEntity>(entityName: "GnomeEntity")
    }

    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var thumbnail: String?
    @NSManaged public var age: Int16
    @NSManaged public var weight: Double
    @NSManaged public var height: Double
    @NSManaged public var professions: NSObject?
    @NSManaged public var friends: NSObject?
    @NSManaged public var hairColor: String?

}
