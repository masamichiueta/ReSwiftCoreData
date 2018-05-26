//
//  UserRepository.swift
//  ReSwiftCoreData
//
//  Created by UetaMasamichi on 9/27/16.
//  Copyright © 2016 MasamichiUeta. All rights reserved.
//

import Foundation
import CoreData

enum RepositoryError {
    case fail
}

typealias FetchUsersCompletionHandler = (_ users: [User]?, _ error: RepositoryError?) -> Void
typealias FetchUserCompletionHandler = (_ user: User?, _ error: RepositoryError?) -> Void
typealias CreateUserCompletionHandler = (_ user: User?, _ error: RepositoryError?) -> Void
typealias UpdateUserCompletionHandler = (_ user: User?, _ error: RepositoryError?) -> Void
typealias DeleteUserCompletionHandler = (_ error: RepositoryError?) -> Void

struct UserRepository {
    
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func fetchUsers(completionHandler: FetchUsersCompletionHandler?) {
        
        context.perform {
            do {
                let request: NSFetchRequest<ManagedUser> = ManagedUser.fetchRequest()
                let managedUsers = try self.context.fetch(request)
                
                completionHandler?(managedUsers.map { $0.toUser() }, nil)
                
            } catch {
                completionHandler?(nil, RepositoryError.fail)
            }
        }
    }
    
    func fetchUser(objectID: String, completionHandler: FetchUserCompletionHandler?) {
        
        context.perform {
            do {
                
                guard let managedObjectId = self.context.persistentStoreCoordinator?.managedObjectID(forURIRepresentation: URL(string: objectID)!) else {
                    
                    completionHandler?(nil, RepositoryError.fail)
                    return
                }
                
                guard let managedUser = try self.context.existingObject(with: managedObjectId) as? ManagedUser else {
                    completionHandler?(nil, RepositoryError.fail)
                    return
                }
                
                let user = managedUser.toUser()
                completionHandler?(user, nil)
                
            } catch {
                completionHandler?(nil, RepositoryError.fail)
            }
        }
    }
    
    func createUser(user: User, completionHandler: CreateUserCompletionHandler?) {
        
        context.perform {
            do {
                let managedUser = ManagedUser(context: self.context)
                managedUser.name = user.name
                managedUser.age = Int16(user.age)
                
                try self.context.save()
                completionHandler?(managedUser.toUser() ,nil)
                
            } catch {
                completionHandler?(nil, RepositoryError.fail)
            }
        }
    }
    
    func updateUser(user: User, completionHandler: UpdateUserCompletionHandler?) {
        
        context.perform {
            do {
                guard let objectID = user.objectID else {
                    completionHandler?(nil, RepositoryError.fail)
                    return
                }
                
                guard let managedObjectId = self.context.persistentStoreCoordinator?.managedObjectID(forURIRepresentation: URL(string: objectID)!) else {
                    completionHandler?(nil, RepositoryError.fail)
                    return
                }
                
                guard let managedUser = try self.context.existingObject(with: managedObjectId) as? ManagedUser else {
                    completionHandler?(nil, RepositoryError.fail)
                    return
                }
                
                managedUser.name = user.name
                managedUser.age = Int16(user.age)
                
                try self.context.save()
                
                completionHandler?(managedUser.toUser(), nil)
                
            } catch {
                completionHandler?(nil, RepositoryError.fail)
            }
        }
    }
    
    func deleteUser(objectID: String, completionHandler: DeleteUserCompletionHandler?) {
        context.perform {
            do {
                guard let managedObjectId = self.context.persistentStoreCoordinator?.managedObjectID(forURIRepresentation: URL(string: objectID)!) else {
                    
                    completionHandler?(RepositoryError.fail)
                    return
                }
                
                guard let managedUser = try self.context.existingObject(with: managedObjectId) as? ManagedUser else {
                    completionHandler?(RepositoryError.fail)
                    return
                }
                
                self.context.delete(managedUser)
                try self.context.save()
                
            } catch {
                completionHandler?(RepositoryError.fail)
            }
        }
        
    }
    
    
}
