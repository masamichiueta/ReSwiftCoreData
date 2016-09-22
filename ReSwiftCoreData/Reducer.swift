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
        case let action as UpdateUser:
            
            let users = state.users.map({ user -> User in
                
                if user.objectID.isEqual(action.user.objectID) {
                    return action.user
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
