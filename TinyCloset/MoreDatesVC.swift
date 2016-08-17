//
//  MoreDatesVC.swift
//  TinyCloset
//
//  Created by Ellen Shin on 7/31/16.
//  Copyright © 2016 Ellen Shin. All rights reserved.
//

import UIKit
import JTAppleCalendar
import CoreData

class MoreDatesVC: UIViewController, JTAppleCalendarViewDelegate, JTAppleCalendarViewDataSource {

    @IBOutlet weak var calendarView: JTAppleCalendarView!
    @IBOutlet weak var currentYearLbl: UILabel!
    @IBOutlet weak var currentMonthLbl: UILabel!
    @IBOutlet weak var currentDateLbl: UILabel!
    @IBOutlet weak var peopleLbl: UILabel!
    @IBOutlet weak var beenCaughtLbl: UILabel!

    
    var outfit: Outfit!
    var currentCell: CalendarCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.calendarView.dataSource = self
        self.calendarView.delegate = self
        self.calendarView.registerCellViewXib(fileName: "CalendarCell")
        calendarView.scrollEnabled = false
        calendarView.pagingEnabled = false
        beenCaughtLbl.hidden = true
        peopleLbl.hidden = true
        
        
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
    
    @IBAction func backBtnPressed(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
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
            
            if selectedCell.worn == true {
                peopleLbl.text = selectedCell.peopleToString()
                peopleLbl.hidden = false
                beenCaughtLbl.hidden = false
            } else {
                beenCaughtLbl.hidden = true
                peopleLbl.hidden = true
            }
        }
    }
    
    func calendar(calendar: JTAppleCalendarView, isAboutToDisplayCell cell: JTAppleDayCellView, date: NSDate, cellState: CellState){
        let dateCell = cell as! CalendarCell
        dateCell.setupCellBeforeDisplay(cellState, date: date)

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
            
            let pairArray = dateEntity.pairs?.allObjects as! [Pair]
            for pair in pairArray {
                
                if pair.outfit == outfit {
                    dateCell.people = pair.people?.allObjects as! [Person]
                    dateCell.circleImg.hidden = false
                    dateCell.worn = true
                }
            }
        }
//        for tup in outfit.wornDates {
//            let wornDate = tup.date
//            dateFormatter.dateFormat = "yyyy MM dd"
//            let convertedWornDate = dateFormatter.stringFromDate(wornDate)
//            print(convertedWornDate)
//            let convertedDate = dateFormatter.stringFromDate(date)
//            print(convertedDate)
//            
//            if convertedDate == convertedWornDate {
//                dateCell.circleImg.hidden = false
//                dateCell.people = tup.people
//                dateCell.worn = true
//            }
//        }
        
        if dateCell.isToday {
            currentCell = dateCell
            if dateCell.worn == true {
                peopleLbl.text = dateCell.peopleToString()
                peopleLbl.hidden = false
                beenCaughtLbl.hidden = false
            } else {
                beenCaughtLbl.hidden = true
                peopleLbl.hidden = true
            }
        }
    }
    
}
