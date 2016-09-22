//
//  User+CoreDataProperties.swift
//  
//
//  Created by UetaMasamichi on 9/22/16.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User");
    }

    @NSManaged public var name: String?
    @NSManaged public var age: Int16

}
