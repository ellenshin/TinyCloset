//
//  SectionCell.swift
//  TinyCloset
//
//  Created by Ellen Shin on 7/25/16.
//  Copyright © 2016 Ellen Shin. All rights reserved.
//

import UIKit
import CoreData

class SectionCell: UITableViewCell {

    @IBOutlet weak var contentLbl: UILabel!
    @IBOutlet weak var minusBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(content: String, tag: String) {
        
        contentLbl.text = content
        minusBtn.titleLabel!.text = tag
    }

//    @IBAction func minusBtnPressed(sender: UIButton) {
//        NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "cellDeleted", object: sender))
//    }
}
