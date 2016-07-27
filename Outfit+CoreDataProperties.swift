//
//  Outfit+CoreDataProperties.swift
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

extension Outfit {

    @NSManaged var image: NSData?
    @NSManaged var lastWorn: String?
    @NSManaged var events: NSSet?
    @NSManaged var season: NSObject?
    @NSManaged var suitcase: Suitcase?
    @NSManaged var lent: Lent?
    @NSManaged var persons: NSSet?
    @NSManaged var types: NSSet?

}
