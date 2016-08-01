//
//  Constants.swift
//  TinyCloset
//
//  Created by Ellen Shin on 7/13/16.
//  Copyright © 2016 Ellen Shin. All rights reserved.
//

import Foundation
import CoreData
import UIKit

var dateFormatter = NSDateFormatter()

enum Seasons: String {
    
    case Spring = "Spring"
    case Summer = "Summer"
    case Fall = "Fall"
    case Winter = "Winter"
    case AllYear = "All year"
}

let color = UIColor(red: 255, green: 127, blue: 80, alpha: 1.0)

extension NSManagedObject {
    func addObject(value: NSManagedObject, forKey key: String) {
        let items = self.mutableSetValueForKey(key)
        items.addObject(value)
    }
    
    func removeObject(value: NSManagedObject, forKey key: String) {
        let items = self.mutableSetValueForKey(key)
        items.removeObject(value)
    }
}

extension UIImage {
    
    func correctlyOrientedImage() -> UIImage {
        if self.imageOrientation == UIImageOrientation.Up {
            return self
        }
        
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        self.drawInRect(CGRectMake(0, 0, self.size.width, self.size.height))
        let normalizedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return normalizedImage;
    }

}