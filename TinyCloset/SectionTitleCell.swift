//
//  SectionTitleCell.swift
//  TinyCloset
//
//  Created by Ellen Shin on 7/25/16.
//  Copyright © 2016 Ellen Shin. All rights reserved.
//

import UIKit

class SectionTitleCell: UITableViewCell {

    @IBOutlet weak var arrowImg: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var addBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse()
    {
        super.prepareForReuse()
        addBtn.tag = 0
    }

    func configureCell(title: String, tag: Int) {
        titleLbl.text = title
        arrowImg.hidden = false
        addBtn.hidden = false
        addBtn.tag = tag
    }
}
