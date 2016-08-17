//
//  Pair.swift
//  TinyCloset
//
//  Created by Ellen Shin on 8/16/16.
//  Copyright © 2016 Ellen Shin. All rights reserved.
//

import Foundation
import CoreData


class Pair: NSManagedObject {

    func getPeopleString() -> String {
        var str = "None"
        if let arr = self.people?.allObjects as? [Person] where arr.count > 0 {
            print(arr.count)
            if let first = arr[0].name {
                str = "\(first)"
            }
            for x in 1..<arr.count {
                if let name = arr[x].name {
                    str = "\(str), \(name)"
                }
            }
        }
        
        return str
    }

    func configureSelf(outfit: Outfit, people: [Person]) {
        self.outfit = outfit
        self.people = NSSet(array: people)
    }
}
