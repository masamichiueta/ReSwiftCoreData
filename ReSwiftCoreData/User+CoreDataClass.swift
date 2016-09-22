//
//  User+CoreDataClass.swift
//  
//
//  Created by UetaMasamichi on 9/22/16.
//
//

import Foundation
import CoreData


public class User: NSManagedObject {

    static func fetch(moc: NSManagedObjectContext) -> [User] {
        let request: NSFetchRequest<User> = User.fetchRequest()
        
        do {
            let results = try moc.fetch(request)
            return results
            
        } catch {
            return []
        }
    }
}
