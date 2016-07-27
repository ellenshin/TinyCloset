//
//  ContentCell.swift
//  TinyCloset
//
//  Created by Ellen Shin on 7/25/16.
//  Copyright © 2016 Ellen Shin. All rights reserved.
//

import UIKit
import CoreData

class ContentCell: UITableViewCell {

    @IBOutlet weak var contentLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(content: String) {
        contentLbl.text = content
    }


}
