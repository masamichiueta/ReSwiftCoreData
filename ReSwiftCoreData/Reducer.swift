//
//  Reducer.swift
//  ReSwiftCoreData
//
//  Created by UetaMasamichi on 9/22/16.
//  Copyright © 2016 MasamichiUeta. All rights reserved.
//

import ReSwift

struct AppReducer: Reducer {
    
    func handleAction(action: Action, state: AppState?) -> AppState {
        
        var state = state ?? AppState()
        
        switch action {
        case let action as AddUser:
            state.users.append(action.user)
            
        case let action as UpdateUserName:
            let users = state.users.map({ user -> User in
                
                if user.objectID.isEqual(action.objectID) {
                    user.name = action.name
                }
                
                return user
            })
            
            state.users = users
        
        case let action as UpdateUserAge:
            let users = state.users.map({ user -> User in
                
                if user.objectID.isEqual(action.objectID) {
                    user.age = action.age
                }
                
                return user
            })
            
            state.users = users
            
        default:
            break
        }
        
        return state
    }
}
