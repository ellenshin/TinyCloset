//
//  SectionInfo.swift
//  TinyCloset
//
//  Created by Ellen Shin on 7/24/16.
//  Copyright © 2016 Ellen Shin. All rights reserved.
//

import UIKit

class SectionInfo: NSObject {
    var open: Bool = true
    var itemsInSection: NSMutableArray = []
    var sectionTitle: String?
    
    init(itemsInSection: NSMutableArray, sectionTitle: String) {
        self.itemsInSection = itemsInSection
        self.sectionTitle = sectionTitle
    }
}