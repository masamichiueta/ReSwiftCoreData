//
//  Action.swift
//  ReSwiftCoreData
//
//  Created by UetaMasamichi on 9/22/16.
//  Copyright © 2016 MasamichiUeta. All rights reserved.
//

import ReSwift

struct FetchUser: Action {
    let users: [User]
}

struct AddUser: Action {
    let user: User
}

struct UpdateUserName: Action {
    let objectID: String
    let name: String
}

struct UpdateUserAge: Action {
    let objectID: String
    let age: Int
}

