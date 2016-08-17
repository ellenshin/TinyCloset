//
//  OutfitListCell.swift
//  TinyCloset
//
//  Created by Ellen Shin on 8/9/16.
//  Copyright © 2016 Ellen Shin. All rights reserved.
//

import UIKit
import CoreData

class OutfitListCell: UITableViewCell {

    @IBOutlet weak var outfitImg: CustomImageView!
    @IBOutlet weak var replaceBtn: UIButton!
    @IBOutlet weak var peopleYouAreSeeingLbl: UILabel!
    @IBOutlet weak var peopleLbl: UILabel!
    
    var outfit: Outfit!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    func configureCell(pair: Pair, tag: Int) {
        self.outfit = pair.outfit
        self.outfitImg.image = UIImage(data: pair.outfit!.image!)
        replaceBtn.tag = tag
        peopleLbl.text = pair.getPeopleString()
        
//        dateFormatter.dateFormat = "yyyy MM dd"
//        let dateString = dateFormatter.stringFromDate(date)
//        
//        let context = ad.managedObjectContext
//        let request = NSFetchRequest(entityName: "Date")
//        let predicate = NSPredicate(format: "name BEGINSWITH[cd] %@", dateString)
//        request.predicate = predicate
//        
//        var results = [Date]()
//        
//        do {
//            results = try context.executeFetchRequest(request) as! [Date]
//            
//        } catch let err as NSError {
//            print(err.debugDescription)
//        }
//
//        let dateEntity = results[0]
//        
//        
//        for tup in outfit.wornDates {
//            if tup.date == date {
//                if tup.people.count > 0 {
//                    var str = ""
//                    if let first = tup.people[0].name {
//                        str = "\(first)"
//                    }
//                    for x in 1..<tup.people.count {
//                        if let name = tup.people[x].name {
//                            str = "\(str), \(name)"
//                        }
//                    }
//                    peopleLbl.text = str
//                }
//            }
//            break
//        }
    }
    
}
