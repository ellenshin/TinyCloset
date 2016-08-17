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
    
//    var wornDates: [(date: NSDate, people: [Person])] =  []
//    
//    var currentPeople: [Person] = []
    
    override func awakeFromInsert() {
        super.awakeFromInsert()
//        test()
    }
    
    func setSeasonType(s: Seasons) {
        self.season = s.rawValue
    }
    
    func setOutfitImage(image: UIImage) {
        let data = UIImagePNGRepresentation(image)
        self.image = data
    }
    
    func willWear(date: NSDate, people: [Person]) {
        let pair = NSEntityDescription.insertNewObjectForEntityForName("Pair", inManagedObjectContext: ad.managedObjectContext) as! Pair
        pair.configureSelf(self, people: people)
        
        insertPairToDate(pair, date: date)
        
    }
    
//    func test() {
//        
//        dateFormatter.dateFormat = "yyyy MM dd"
//        let date = dateFormatter.dateFromString("2016 08 27")
//        let people: [Person] = []
//        let tup = (date: date!, people: people)
//        wornDates.append(tup)
//    }
    
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
    
    func insertPairToDate(pair: Pair, date: NSDate) {
        dateFormatter.dateFormat = "yyyy MM dd"
        let dateString = dateFormatter.stringFromDate(date)
        let context = ad.managedObjectContext
        let request = NSFetchRequest(entityName: "Date")
        let predicate = NSPredicate(format: "name BEGINSWITH[cd] %@", dateString)
        request.predicate = predicate
        
        var results = [Date]()
        
        do {
            results = try context.executeFetchRequest(request) as! [Date]
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        if results.count > 0 {
            results[0].addObject(pair, forKey: "pairs")
        } else {
            let newDate = NSEntityDescription.insertNewObjectForEntityForName("Date", inManagedObjectContext: ad.managedObjectContext) as! Date
            newDate.configureSelf(pair, date: date)
        }

    }
    
    func wearToday(people: [Person]) {
        let date = NSDate()
        
        let pair = NSEntityDescription.insertNewObjectForEntityForName("Pair", inManagedObjectContext: ad.managedObjectContext) as! Pair
        pair.configureSelf(self, people: people)
        
        insertPairToDate(pair, date: date)
        
        lastWorn = date
    }
    
}
