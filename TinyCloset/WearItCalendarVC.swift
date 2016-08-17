//
//  WearItCalendarVC.swift
//  TinyCloset
//
//  Created by Ellen Shin on 8/8/16.
//  Copyright © 2016 Ellen Shin. All rights reserved.
//

import UIKit
import CoreData
import JTAppleCalendar

class WearItCalendarVC: UIViewController, JTAppleCalendarViewDelegate, JTAppleCalendarViewDataSource {
    
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    @IBOutlet weak var currentYearLbl: UILabel!
    @IBOutlet weak var currentMonthLbl: UILabel!
    @IBOutlet weak var currentDateLbl: UILabel!
    @IBOutlet weak var alreadyLbl: UILabel!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var chooseThisBtn: UIButton!
    @IBOutlet weak var alreadyWearingLbl: UILabel!
    
    var currentCell: CalendarCell!
    var outfit: Outfit!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.calendarView.dataSource = self
        self.calendarView.delegate = self
        self.calendarView.registerCellViewXib(fileName: "CalendarCell")
        calendarView.scrollEnabled = false
        calendarView.pagingEnabled = false
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(WearItCalendarVC.onReplacedOutfit), name: "replacedOutfit", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(WearItCalendarVC.onAddedOutfit), name: "addedOutfit", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(WearItCalendarVC.onOutfitScheduled), name: "outfitScheduled", object: nil)
    }
    
    func onOutfitScheduled() {
        calendarView.reloadData()
    }
    
    func onReplacedOutfit(notif: NSNotification) {
        
        let pairToBeReplaced = notif.object as! Pair
        pairToBeReplaced.outfit = outfit

        calendarView.reloadData()
    }
    
    func onAddedOutfit(notif: NSNotification) {
        performSegueWithIdentifier("WearItPeopleVC", sender: outfit)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "WearItPeopleVC" {
            if let VC = segue.destinationViewController as? WearItPeopleVC {
                if let outfit = sender as? Outfit {
                    VC.outfit = outfit
                    VC.date = currentCell.date
                }
            }
        } else if segue.identifier == "EditListVC" {
            if let VC = segue.destinationViewController as? EditListVC {
                if let cell = sender as? CalendarCell {
                    VC.pairList = cell.pairList
                    VC.date = currentCell.date
                    VC.outfit = self.outfit
                }
            }
        }
    }
    
    func configureCalendar(calendar: JTAppleCalendarView) -> (startDate: NSDate, endDate: NSDate, numberOfRows: Int, calendar: NSCalendar) {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        
        let firstDate = NSDate()
        let secondDate = NSDate()
        let today = NSDate()
        todayDate = formatter.stringFromDate(today)
        
        let aCalendar = NSCalendar.currentCalendar() // Properly configure your calendar to your time zone here
        return (startDate: firstDate, endDate: secondDate, numberOfRows: 5, calendar: aCalendar)
        
    }
    
    @IBAction func leftArrowTapped(sender: AnyObject) {
        calendarView.scrollToPreviousSegment()
    }
    
    @IBAction func rightArrowTapped(sender: AnyObject) {
        calendarView.scrollToNextSegment()
    }
    
    @IBAction func cancelBtnPressed(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    func calendar(calendar: JTAppleCalendarView, didSelectDate date: NSDate, cell: JTAppleDayCellView?, cellState: CellState) {
        if let selectedCell = cell as? CalendarCell {
            selectedCell.todayCircle.hidden = false
            currentCell.todayCircle.hidden = true
            currentCell = selectedCell
            dateFormatter.dateFormat = "EEEE, MMM dd"
            currentDateLbl.text = dateFormatter.stringFromDate(currentCell.date)
            
            if currentCell.circleImg.hidden == false {
                if currentCell.alreadyWearing == false {
                    chooseThisBtn.hidden = true
                    editBtn.hidden = false
                    alreadyLbl.hidden = false
                    alreadyWearingLbl.hidden = true
                } else {
                    chooseThisBtn.hidden = true
                    editBtn.hidden = true
                    alreadyLbl.hidden = true
                    alreadyWearingLbl.hidden = false
                }
            } else {
                if currentCell.alreadyWearing == false {
                    chooseThisBtn.hidden = false
                    editBtn.hidden = true
                    alreadyLbl.hidden = true
                    alreadyWearingLbl.hidden = true
                } else {
                    chooseThisBtn.hidden = true
                    editBtn.hidden = true
                    alreadyLbl.hidden = true
                    alreadyWearingLbl.hidden = false
                }
            }
        }
    }
    
    func calendar(calendar: JTAppleCalendarView, isAboutToDisplayCell cell: JTAppleDayCellView, date: NSDate, cellState: CellState){
        let dateCell = cell as! CalendarCell
        dateCell.setupCellBeforeDisplay(cellState, date: date)
        if dateCell.isToday {
            currentCell = dateCell
        }
        
        dateFormatter.dateFormat = "yyyy MM dd"
        let dateString = dateFormatter.stringFromDate(date)
        let context = ad.managedObjectContext
        let request = NSFetchRequest(entityName: "Date")
        let predicate = NSPredicate(format: "name BEGINSWITH[cd] %@", dateString)
        request.predicate = predicate
        
        var results = [Date]()
        
        do {
            results = try context.executeFetchRequest(request) as! [Date]
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        if results.count > 0 {
            let dateEntity = results[0]
            
            let array = dateEntity.pairs?.allObjects as! [Pair]
            
            for pair in array {
                if pair.outfit != outfit {
                    dateCell.pairList.append(pair)
                } else {
                    dateCell.alreadyWearing = true
                    
                    print("true\(dateString)")
                }
            }
        }
        
        if dateCell.pairList.count > 0 {
            dateCell.circleImg.hidden = false
        }
        
        if dateCell.isToday {
            currentCell = dateCell
        }
    }
    
    @IBAction func chooseThisBtnPressed(sender: AnyObject) {
        
        self.performSegueWithIdentifier("WearItPeopleVC", sender: self.outfit)
        
    }
    
    @IBAction func editBtnPressed(sender: AnyObject) {
        performSegueWithIdentifier("EditListVC", sender: currentCell)
    }

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}