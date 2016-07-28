//
//  CustomDropdownMenu.swift
//  TinyCloset
//
//  Created by Ellen Shin on 7/12/16.
//  Copyright © 2016 Ellen Shin. All rights reserved.
//

import UIKit
import BTNavigationDropdownMenu

class CustomDropdownMenu: BTNavigationDropdownMenu {
    
    override init(navigationController: UINavigationController?, title: String, items: [AnyObject]) {
        super.init(navigationController: navigationController, title: title, items: items)
        self.cellBackgroundColor = UIColor.whiteColor()
        self.cellSelectionColor = UIColor.whiteColor()
        self.cellSeparatorColor = UIColor.whiteColor()
        self.cellTextLabelColor = UIColor(red: 255.0/255.0, green:127.0/255.0, blue:80.0/255.0, alpha: 1.0)
        self.keepSelectedCellColor = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
