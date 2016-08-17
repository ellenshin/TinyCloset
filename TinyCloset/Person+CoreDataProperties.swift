//
//  Person+CoreDataProperties.swift
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

extension Person {

    @NSManaged var name: String?
    @NSManaged var lent: NSSet?
    @NSManaged var outfits: NSSet?
    @NSManaged var suitcase: Suitcase?
    @NSManaged var pairs: NSSet?

}
