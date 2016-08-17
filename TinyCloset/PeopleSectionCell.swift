//
//  PeopleSectionCell.swift
//  TinyCloset
//
//  Created by Ellen Shin on 8/10/16.
//  Copyright © 2016 Ellen Shin. All rights reserved.
//

import UIKit

class PeopleSectionCell: UITableViewCell {

    @IBOutlet weak var contentLbl: UILabel!
    @IBOutlet weak var daysAgoLbl: UILabel!
    @IBOutlet weak var minusBtn: UIButton!
    
    var person: Person!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(content: Person) {
        person = content
        contentLbl.text = person.name
        daysAgoLbl.text = computeDaysAgo()
        
    }
    @IBAction func minusBtnPressed(sender: AnyObject) {
        
    }
    
    func computeDaysAgo() -> String {
        return "2 outfits, 27 days ago"
    }
    
}