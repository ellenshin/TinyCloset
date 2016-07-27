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

    var wornDates = NSMutableArray()
    var peopleArray = [Person]()
    var favorite: Bool!
    
    override func awakeFromInsert() {
        super.awakeFromInsert()
        self.lastWorn = "Never"
        self.favorite = false
    }
    
    func setSeasonType(s: Seasons) {
        self.season = s.rawValue
    }
    
    func setOutfitImage(image: UIImage) {
        let data = UIImagePNGRepresentation(image)
        self.image = data
    }
    
    func getPeopleAsString() -> String {
        
        var str = ""
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
        var str = ""
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
    
    func setClothingType(types: [Type]) {
        self.types = NSSet(array: types)
    }
    
    func setFavorite(bool: Bool) {
        favorite = bool
    }
    
    func changeFavorite() {
        if self.favorite == true {
            favorite = false
        } else {
            favorite = true
        }
    }
    
    func wearToday() {
        dateFormatter.dateFormat = "EEEE, MMMM dd"
        
        let date = NSDate()
        let convertedDate = dateFormatter.stringFromDate(date)
        
        wornDates.addObject(convertedDate)
        lastWorn = wornDates[wornDates.count - 1] as? String
    }

}
