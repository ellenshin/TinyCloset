//
//  CalendarVC.swift
//  TinyCloset
//
//  Created by Ellen Shin on 8/14/16.
//  Copyright © 2016 Ellen Shin. All rights reserved.
//

import UIKit
import JTAppleCalendar
import CoreData

class CalendarVC: UIViewController, JTAppleCalendarViewDelegate, JTAppleCalendarViewDataSource {

    @IBOutlet weak var calendarView: JTAppleCalendarView!
    @IBOutlet weak var currentYearLbl: UILabel!
    @IBOutlet weak var currentMonthLbl: UILabel!
    @IBOutlet weak var currentDateLbl: UILabel!
    @IBOutlet weak var outfitImg: UIImageView!
    @IBOutlet weak var peopleLbl: UILabel!
    @IBOutlet weak var dontHaveOutfitLbl: UILabel!
    @IBOutlet weak var pickAnOutfitBtn: CustomButton!
    @IBOutlet weak var viewMoreBtn: UIButton!
    @IBOutlet weak var peopleStaticLbl: UILabel!
    @IBOutlet weak var replaceBtn: CustomButton!

    var currentCell: CalendarCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.calendarView.dataSource = self
        self.calendarView.delegate = self
        self.calendarView.registerCellViewXib(fileName: "CalendarCell")
        calendarView.scrollEnabled = false
        calendarView.pagingEnabled = false
        
        calendarView.reloadData()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CalendarVC.onReplacedOutfit), name: "replacedOutfit", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CalendarVC.onAddedOutfit), name: "addedOutfit", object: nil)
    }

    func onReplacedOutfit(notif: NSNotification) {
        
    }
    
    func onAddedOutfit(notif: NSNotification) {
        
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
    @IBAction func viewMoreBtnPressed(sender: AnyObject) {
        performSegueWithIdentifier("ViewMoreOutfitsVC", sender: nil)
    }

    @IBAction func leftArrowTapped(sender: AnyObject) {
        calendarView.scrollToPreviousSegment()
    }
    
    @IBAction func rightArrowTapped(sender: AnyObject) {
        calendarView.scrollToNextSegment()
    }
    

    func calendar(calendar: JTAppleCalendarView, didSelectDate date: NSDate, cell: JTAppleDayCellView?, cellState: CellState) {
        if let selectedCell = cell as? CalendarCell {
            selectedCell.todayCircle.hidden = false
            currentCell.todayCircle.hidden = true
            currentCell = selectedCell
            dateFormatter.dateFormat = "EEEE, MMM dd"
            currentDateLbl.text = dateFormatter.stringFromDate(currentCell.date)
            
            if selectedCell.circleImg.hidden == false {
                displayOneOutfit()
            } else {
                undisplay()
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
                
                dateCell.pairList.append(pair)
                
            }
        }

//        let context = ad.managedObjectContext
//        let fetchRequest = NSFetchRequest(entityName: "Outfit")
//        do {
//            let fetchedOutfits = try context.executeFetchRequest(fetchRequest) as! [Outfit]
//            
//            for outfit in fetchedOutfits {
//                
//                let worns = outfit.wornDates
//                for worn in worns {
//                    if worn.date == date {
//                        dateCell.outfitList.append(outfit)
//                    }
//                }
//                
//            }
//        } catch {
//            // Do something in response to error condition
//        }
        
        if dateCell.pairList.count > 0 {
            dateCell.circleImg.hidden = false
        }
        
        if dateCell.isToday {
            currentCell = dateCell
        }
    }
    
    func undisplay() {
        pickAnOutfitBtn.hidden = false
        dontHaveOutfitLbl.hidden = false
        replaceBtn.hidden = true
        
        outfitImg.hidden = true
        peopleStaticLbl.hidden = true
        peopleLbl.hidden = true
        viewMoreBtn.hidden = true
    }
    
    func displayOneOutfit() {
        pickAnOutfitBtn.hidden = true
        dontHaveOutfitLbl.hidden = true
        
        let firstPair = currentCell.pairList[0]
        
        outfitImg.image = UIImage(data: firstPair.outfit!.image!)
        
        peopleLbl.text = firstPair.getPeopleString()
        
        outfitImg.hidden = false
        peopleStaticLbl.hidden = false
        peopleLbl.hidden = false
        replaceBtn.hidden = false
        
        if currentCell.pairList.count > 1 {
            viewMoreBtn.hidden = false
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ViewMoreOutfitsVC" {
            if let VC = segue.destinationViewController as? ViewMoreOutfitsVC {
                VC.date = currentCell.date
            }
        }
    }

    @IBAction func replaceBtnPressed(sender: AnyObject) {
    }
    
}
