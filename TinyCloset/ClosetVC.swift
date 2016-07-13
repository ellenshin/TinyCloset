//
//  ClosetVC.swift
//  TinyCloset
//
//  Created by Ellen Shin on 7/12/16.
//  Copyright © 2016 Ellen Shin. All rights reserved.
//

import UIKit
import BTNavigationDropdownMenu

class ClosetVC: UIViewController {

    let items = ["Most Recent", "Least Recent", "Most Frequent", "Least Frequent", "Favorites"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let menuView = BTNavigationDropdownMenu(navigationController: self.navigationController, title: items.first!, items: items)
        self.navigationController?.navigationBar.translucent = false
        menuView.cellBackgroundColor = self.navigationController?.navigationBar.barTintColor
        menuView.cellSelectionColor = UIColor(red: 255.0/255.0, green:82.0/255.0, blue:82.0/255.0, alpha: 0.8)
        menuView.cellSeparatorColor = UIColor(red: 255.0/255.0, green:82.0/255.0, blue:82.0/255.0, alpha: 1.0)
    
        menuView.keepSelectedCellColor = true

        self.navigationItem.titleView = menuView
    }

}