//
//  Outfit+CoreDataProperties.swift
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

extension Outfit {

    @NSManaged var favorite: NSNumber?
    @NSManaged var image: NSData?
    @NSManaged var lastWorn: NSDate?
    @NSManaged var season: NSObject?
    @NSManaged var events: NSSet?
    @NSManaged var lent: Lent?
    @NSManaged var persons: NSSet?
    @NSManaged var suitcase: Suitcase?
    @NSManaged var types: NSSet?
    @NSManaged var dates: NSSet?
    @NSManaged var pair: NSSet?

}
