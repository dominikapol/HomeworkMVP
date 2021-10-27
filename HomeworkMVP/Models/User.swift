//
//  User+CoreDataClass.swift
//  HomeworkMVP
//
//  Created by Dominika Poleshyck on 3.10.21.
//
//

import Foundation
import CoreData

@objc(User)
public class User: NSManagedObject, Identifiable{

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var cells: String?

}
