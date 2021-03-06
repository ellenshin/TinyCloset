//
//  Date+CoreDataProperties.swift
//  TinyCloset
//
//  Created by Ellen Shin on 8/16/16.
//  Copyright © 2016 Ellen Shin. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Date {

    @NSManaged var date: NSDate?
    @NSManaged var name: String?
    @NSManaged var pastOrFuture: NSNumber?
    @NSManaged var pairs: NSSet?

}
