//
//  OutfitDetailsVC.swift
//  TinyCloset
//
//  Created by Ellen Shin on 7/31/16.
//  Copyright © 2016 Ellen Shin. All rights reserved.
//

import UIKit
import SCLAlertView

class OutfitDetailsVC: UIViewController {

    @IBOutlet weak var outfitImg: UIImageView!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var daysAgoLbl: UILabel!
    @IBOutlet weak var eventLbl: UILabel!
    @IBOutlet weak var seasonLbl: UILabel!
    @IBOutlet weak var typesLbl: UILabel!
    @IBOutlet weak var peopleLbl: UILabel!
    @IBOutlet weak var heartImg: UIImageView!
    
    var outfit: Outfit!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let date = outfit.lastWorn {
            dateFormatter.dateFormat = "EEEE, MMM dd"
            let convertedDate = dateFormatter.stringFromDate(date)
            dateLbl.text = convertedDate
        } else {
            dateLbl.text = "Never worn"
        }
        
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
        
        if outfit.favorite == false {
            heartImg.image = UIImage(named: "heart-empty")
        } else {
            heartImg.image = UIImage(named: "heart-full")
        }
        
    }
    
    func getDaysAgo() -> Int {
        let todayDate = NSDate()
        let calendar: NSCalendar = NSCalendar.currentCalendar()
        
        let date1 = calendar.startOfDayForDate(outfit.lastWorn!)
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
        } else if segue.identifier == "WearItCalendarVC" {
            if let VC = segue.destinationViewController as? WearItCalendarVC {
                if let outfit = sender as? Outfit {
                    VC.outfit = outfit
                }
            }
        } else if segue.identifier == "EditOutfitVC" {
            if let VC = segue.destinationViewController as? EditOutfitVC {
                if let outfit = sender as? Outfit {
                    VC.outfit = outfit
                }
            }
        }
    }
    
    @IBAction func wearItBtnPressed(sender: AnyObject) {
        performSegueWithIdentifier("WearItCalendarVC", sender: outfit)
    }
    
    @IBAction func showMoreBtnPressed(sender: AnyObject) {
        performSegueWithIdentifier("MoreDatesVC", sender: outfit)
        print("pressed")
    }
    
    @IBAction func trashBtnPressed(sender: AnyObject) {
        let alert = SCLAlertView()
        alert.addButton("Confirm") {
            self.navigationController?.popToRootViewControllerAnimated(true)
            NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "outfitDeleted", object: self.outfit))
        }
        
        alert.addButton("Cancel") {
            alert.hideView()
        }
        alert.showWarning("Warning!", subTitle: "Are you sure you want to delete this outfit?")
    }
    
    @IBAction func editBtnPressed(sender: AnyObject) {
        performSegueWithIdentifier("EditOutfitVC", sender: outfit)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
   }
