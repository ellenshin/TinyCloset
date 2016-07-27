//
//  dataService.swift
//  TinyCloset
//
//  Created by Ellen Shin on 7/20/16.
//  Copyright © 2016 Ellen Shin. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DataService {
    
    static let instance = DataService()
    
    var newOutfitImage: UIImage?
    
    //var addedContent: NSObject?
    
    func setImage(image: UIImage) {
        newOutfitImage = image
    }
    
    var alertType: String?
    
}