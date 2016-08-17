//
//  CalendarCell.swift
//  TinyCloset
//
//  Created by Ellen Shin on 7/31/16.
//  Copyright © 2016 Ellen Shin. All rights reserved.
//

import Foundation
import JTAppleCalendar

class CalendarCell: JTAppleDayCellView {
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var circleImg: UIImageView!
    @IBOutlet weak var todayCircle: UIImageView!
    
    var people = [Person]()
    var worn = false
    var normalDayColor = UIColor.blackColor()
    var weekendDayColor = UIColor.grayColor()
    var state: CellState?
    var isToday = false
    var date: NSDate!
    var pairList: [Pair] = []
    var alreadyWearing = false
    
    func setupCellBeforeDisplay(cellState: CellState, date: NSDate) {
        // Setup Cell text
        dayLabel.text =  cellState.text
        
        // Setup text color
        configureTextColor(cellState)
        circleImg.hidden = true
        todayCircle.hidden = true
        dateFormatter.dateFormat = "yyyy MM dd"
        state = cellState
        self.date = date
        if dateFormatter.stringFromDate(date) == todayDate {
            todayCircle.hidden = false
            isToday = true
        }
        
        
    }
    
    func configureTextColor(cellState: CellState) {
        if cellState.dateBelongsTo == .ThisMonth {
            dayLabel.textColor = normalDayColor
        } else {
            dayLabel.textColor = weekendDayColor
        }
    }
    
    func peopleToString() -> String {
        var str = ""
        if people.count > 0 {
            if let first = people[0].name {
                str = "\(first)"
            }
            for x in 1..<people.count {
                if let name = people[x].name {
                    str = "\(str), \(name)"
                }
            }
        }
        return str
    }
}

extension UIColor {
    convenience init(colorWithHexValue value: Int, alpha:CGFloat = 1.0){
        self.init(
            red: CGFloat((value & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((value & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(value & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}