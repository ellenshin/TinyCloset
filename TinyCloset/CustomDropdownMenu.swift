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
        self.cellBackgroundColor = UIColor(red: 132.0/255.0, green:227.0/255.0, blue:216.0/255.0, alpha: 1.0)
        self.cellSelectionColor = UIColor(red: 101.0/255.0, green:175.0/255.0, blue:168.0/255.0, alpha: 0.8)
        self.cellSeparatorColor = UIColor(red: 101.0/255.0, green:175.0/255.0, blue:168.0/255.0, alpha: 1.0)
        self.cellTextLabelColor = UIColor.whiteColor()
        self.keepSelectedCellColor = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
