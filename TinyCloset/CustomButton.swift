//
//  CustomButton.swift
//  TinyCloset
//
//  Created by Ellen Shin on 7/13/16.
//  Copyright © 2016 Ellen Shin. All rights reserved.
//

import UIKit

class CustomButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 4.0
        self.clipsToBounds = true
        self.layer.shadowRadius = 1.0
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor(red: 157.0/255.0, green: 157.0/255.0, blue: 157.0/255.0, alpha: 1.0).CGColor
        self.layer.shadowOpacity = 0.8
        self.layer.shadowOffset = CGSizeMake(1.0, 1.5)
    }

}
