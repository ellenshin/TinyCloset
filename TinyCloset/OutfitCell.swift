//
//  OutfitCell.swift
//  TinyCloset
//
//  Created by Ellen Shin on 7/12/16.
//  Copyright © 2016 Ellen Shin. All rights reserved.
//

import UIKit

class OutfitCell: UICollectionViewCell {

    @IBOutlet weak var outfitImg: CustomImageView!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var occasionLbl: UILabel!
    @IBOutlet weak var peopleLbl: UILabel!
    @IBOutlet weak var wearBtn: CustomButton!
    @IBOutlet weak var packBtn: CustomButton!
    @IBOutlet weak var lentBtn: UIButton!
    @IBOutlet weak var heartImg: UIImageView!
    
    var outfit: Outfit!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configureCell(outfit: Outfit) {
        
        if let img = outfit.image {
            outfitImg.image = UIImage(data: img)?.correctlyOrientedImage()
        }
        
        if let date = outfit.lastWorn {
            dateFormatter.dateFormat = "EEEE, MMM dd"
            let convertedDate = dateFormatter.stringFromDate(date)
            dateLbl.text = convertedDate
        } else {
            dateLbl.text = "Never worn"
        }
        
        let occ = outfit.getEventsAsString()
        occasionLbl.text = occ
        
        
        let people = outfit.getPeopleAsString()
        peopleLbl.text = people
        
        if outfit.favorite == true {
            heartImg.image = UIImage(named: "heart-full")
        } else {
            heartImg.image = UIImage(named: "heart-empty")
        }
        
        self.outfit = outfit
    }

    @IBAction func heartBtnPressed(sender: AnyObject) {
        if outfit.favorite == true {
            heartImg.image = UIImage(named: "heart-full")
        } else {
            heartImg.image = UIImage(named: "heart-empty")
        }
        outfit.changeFavorite()
    }
    
}
