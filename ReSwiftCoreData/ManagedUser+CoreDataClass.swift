//
//  ManagedUser+CoreDataClass.swift
//  ReSwiftCoreData
//
//  Created by UetaMasamichi on 9/27/16.
//  Copyright © 2016 MasamichiUeta. All rights reserved.
//

import Foundation
import CoreData


public class ManagedUser: NSManagedObject {
    
    func toUser() -> User {
        return User(objectID: self.objectID.uriRepresentation().absoluteString, name: self.name ?? "", age: Int(self.age))
    }
}
