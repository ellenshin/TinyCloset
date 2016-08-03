//
//  Outfit.swift
//  TinyCloset
//
//  Created by Ellen Shin on 7/14/16.
//  Copyright © 2016 Ellen Shin. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class Outfit: NSManagedObject {
    
    var wornDates: [(date: NSDate, people: NSSet)] =  []
    
    override func awakeFromInsert() {
        super.awakeFromInsert()
    }
    
    func setSeasonType(s: Seasons) {
        self.season = s.rawValue
    }
    
    func setOutfitImage(image: UIImage) {
        let data = UIImagePNGRepresentation(image)
        self.image = data
    }
    
    func getPeopleAsString() -> String {
        
        var str = "None"
        if let arr = self.persons?.allObjects as? [Person] where arr.count > 0 {
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
    
    func getEventsAsString() -> String {
        var str = "None"
        if let arr = self.events?.allObjects as? [Event] where arr.count > 0 {
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
    
    func getTypesAsString() -> String {
        var str = "None"
        if let arr = self.types?.allObjects as? [Type] where arr.count > 0 {
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
    
    func setClothingType(types: [Type]) {
        self.types = NSSet(array: types)
    }
    
    func changeFavorite() {
        if self.favorite == true {
            favorite = false
        } else {
            favorite = true
        }
    }
    
    func wearToday() {
        let date = NSDate()
        let dateSet = (date, self.persons!)
        wornDates.append(dateSet)
        
        //        dateFormatter.dateFormat = "EEEE, MMM dd"
        //        let convertedDate = dateFormatter.stringFromDate(date)
        //        lastWorn = convertedDate
        
        lastWorn = date
    }
    
}
