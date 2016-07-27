//
//  Lent+CoreDataProperties.swift
//  TinyCloset
//
//  Created by Ellen Shin on 7/14/16.
//  Copyright © 2016 Ellen Shin. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Lent {

    @NSManaged var startDate: NSDate?
    @NSManaged var endDate: NSDate?
    @NSManaged var outfit: Outfit?
    @NSManaged var person: Person?

}
