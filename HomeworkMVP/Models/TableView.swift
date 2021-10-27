//
//  TableView+CoreDataClass.swift
//  HomeworkMVP
//
//  Created by Dominika Poleshyck on 3.10.21.
//
//

import Foundation
import CoreData

@objc(TableView)
public class TableView: NSManagedObject, Identifiable {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<TableView> {
        return NSFetchRequest<TableView>(entityName: "TableView")
    }

    @NSManaged public var cells: String?
    @NSManaged public var creationData: NSData?
    @NSManaged public var user: User?
}
