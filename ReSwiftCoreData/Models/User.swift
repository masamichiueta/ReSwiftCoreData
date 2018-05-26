//
//  User.swift
//  ReSwiftCoreData
//
//  Created by UetaMasamichi on 9/27/16.
//  Copyright © 2016 MasamichiUeta. All rights reserved.
//

import Foundation

struct User {
    
    var objectID: String?
    var name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.init(objectID: nil, name: name, age: age)
    }
    
    init(objectID: String?, name: String, age: Int) {
        self.objectID = objectID
        self.name = name
        self.age = age
    }
    
}
