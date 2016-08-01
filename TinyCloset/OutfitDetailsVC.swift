//
//  OutfitDetailsVC.swift
//  TinyCloset
//
//  Created by Ellen Shin on 7/31/16.
//  Copyright © 2016 Ellen Shin. All rights reserved.
//

import UIKit

class OutfitDetailsVC: UIViewController {

    @IBOutlet weak var outfitImg: UIImageView!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var daysAgoLbl: UILabel!
    @IBOutlet weak var eventLbl: UILabel!
    @IBOutlet weak var seasonLbl: UILabel!
    @IBOutlet weak var typesLbl: UILabel!
    @IBOutlet weak var peopleLbl: UILabel!
    
    var outfit: Outfit!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateLbl.text = outfit.lastWorn
        if outfit.lastWorn != "Never" {
            daysAgoLbl.text = "\(getDaysAgo()) days ago"
        } else {
            daysAgoLbl.text = ""
        }
        eventLbl.text = outfit.getEventsAsString()
        seasonLbl.text = "\(outfit.season!)"
        typesLbl.text = outfit.getTypesAsString()
        peopleLbl.text = outfit.getPeopleAsString()
        outfitImg.image = UIImage(data: outfit.image!)
        
    }
    
    func getDaysAgo() -> Int {
        let todayDate = NSDate()
        let calendar: NSCalendar = NSCalendar.currentCalendar()
        
        let date1 = calendar.startOfDayForDate(outfit.wornDates[outfit.wornDates.count - 1] as! NSDate)
        let date2 = calendar.startOfDayForDate(todayDate)
        
        let flags = NSCalendarUnit.Day
        let components = calendar.components(flags, fromDate: date1, toDate: date2, options: [])
        
        return components.day
    }
   
    @IBAction func backBtnPressed(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "MoreDatesVC" {
            if let VC = segue.destinationViewController as? MoreDatesVC {
                if let outfit = sender as? Outfit {
                    VC.outfit = outfit
                }
            }
        }
    }
    
    @IBAction func showMoreBtnPressed(sender: AnyObject) {
        performSegueWithIdentifier("MoreDatesVC", sender: outfit)
        print("pressed")
    }
    
   }
