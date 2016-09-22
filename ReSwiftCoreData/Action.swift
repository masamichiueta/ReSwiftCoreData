//
//  Action.swift
//  ReSwiftCoreData
//
//  Created by UetaMasamichi on 9/22/16.
//  Copyright © 2016 MasamichiUeta. All rights reserved.
//

import ReSwift
import CoreData

struct AddUser: Action {
    let user: User
}

struct UpdateUserName: Action {
    let objectID: NSManagedObjectID
    let name: String
    
}

struct UpdateUserAge: Action {
    let objectID: NSManagedObjectID
    let age: Int16
}
