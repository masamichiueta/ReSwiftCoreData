//
//  ManagedUser+CoreDataProperties.swift
//  ReSwiftCoreData
//
//  Created by UetaMasamichi on 9/27/16.
//  Copyright © 2016 MasamichiUeta. All rights reserved.
//

import Foundation
import CoreData


extension ManagedUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedUser> {
        return NSFetchRequest<ManagedUser>(entityName: "ManagedUser");
    }

    @NSManaged public var age: Int16
    @NSManaged public var name: String?

}
