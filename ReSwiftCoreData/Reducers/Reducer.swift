//
//  Reducer.swift
//  ReSwiftCoreData
//
//  Created by UetaMasamichi on 9/22/16.
//  Copyright © 2016 MasamichiUeta. All rights reserved.
//

import ReSwift

func appReducer(action: Action, state: AppState?) -> AppState {
    var state = state ?? AppState()

    switch action {
    case let action as FetchUser:
        state.users = action.users

    case let action as AddUser:
        state.users.append(action.user)

    case let action as UpdateUserName:

        let users = state.users.map({ user -> User in

            if let objectID = user.objectID, objectID == action.objectID {
                return User(objectID: objectID, name: action.name, age: user.age)
            }

            return user
        })

        state.users = users

    case let action as UpdateUserAge:
        let users = state.users.map({ user -> User in

            if let objectID = user.objectID, objectID == action.objectID {
                return User(objectID: objectID, name: user.name, age: action.age)
            }

            return user
        })

        state.users = users

    default:
        break
    }

    return state
}
