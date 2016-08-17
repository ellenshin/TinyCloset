//
//  Pair+CoreDataProperties.swift
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

extension Pair {

    @NSManaged var outfit: Outfit?
    @NSManaged var people: NSSet?
    @NSManaged var date: Date?

}
