//
//  Date.swift
//  TinyCloset
//
//  Created by Ellen Shin on 8/16/16.
//  Copyright © 2016 Ellen Shin. All rights reserved.
//

import Foundation
import CoreData


class Date: NSManagedObject {
    
    func configureSelf(pair: Pair, date: NSDate) {
        self.addObject(pair, forKey: "pairs")
        self.date = date
        dateFormatter.dateFormat = "yyyy MM dd"
        self.name = dateFormatter.stringFromDate(date)
    }
    
}