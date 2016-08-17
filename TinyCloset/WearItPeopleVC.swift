//
//  WearItPeopleVC.swift
//  TinyCloset
//
//  Created by Ellen Shin on 8/9/16.
//  Copyright © 2016 Ellen Shin. All rights reserved.
//

import UIKit
import SCLAlertView
import NAExpandableTableController

class WearItPeopleVC: UIViewController, NAExpandableTableViewDataSource, NAExpandableTableViewDelegate {

    @IBOutlet weak var outfitImg: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    private var expandableTableController: NAExpandableTableController!
    let expandableSectionIndices = [0]
    var peopleArray = [Person]()
    var sectionTitles: [String] = ["People"]
    var outfit: Outfit!
    var date: NSDate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.expandableTableController = NAExpandableTableController(dataSource: self, delegate: self)
        self.expandableTableController.exclusiveExpand = false
        
        tableView.delegate = self.expandableTableController
        tableView.dataSource = self.expandableTableController
        tableView.tableFooterView = UIView(frame: CGRectZero)
        
        preExpand(0)
        tableView.reloadData()
        
        if outfit != nil {
            outfitImg.image = UIImage(data: self.outfit.image!)
        }
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(WearItPeopleVC.onContentAdded), name: "contentAdded", object: nil)
    }
    @IBAction func cancelBtnPressed(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }

    @IBAction func doneBtnPressed(sender: AnyObject) {
        
        outfit.willWear(date, people: peopleArray)
        
        let alert = SCLAlertView()
        alert.addButton("Done") {
            self.navigationController?.popViewControllerAnimated(true)
        }
        
        
        alert.showSuccess("Success!", subTitle: "Your outfit was successfully scheduled")
        NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "outfitScheduled", object: nil))
    }
    
    @IBAction func addBtnPressed(sender: UIButton) {
        performSegueWithIdentifier("SearchVC", sender: sender.tag)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SearchVC" {
            if let searchVC = segue.destinationViewController as? SearchVC {
                searchVC.contentKind = "People"
            }
        }
    }
    
    func onContentAdded(notification: NSNotification) {
        if let content = notification.object as? Person {
            peopleArray.append(content)
            if expandableTableController.expandDict[0] == false {
                preExpand(0)
            }
        }
        tableView.reloadData()
    }
    
    func preExpand(section: Int) {
        expandableTableController.expandDict[0] = true
        tableView.beginUpdates()
        
        var indexPaths = [NSIndexPath]()
        if let rows = expandableTableController.dataSource?.expandableTableView(tableView, numberOfRowsInSection: 0) {
            if rows > 0 {
                for rowIndex in 1...rows {
                    indexPaths.append(NSIndexPath(forRow: rowIndex, inSection: 0))
                }
            }
        }
        
        tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .None)
        tableView.endUpdates()
        
        expandableTableController.delegate?.expandableTableView?(tableView, didExpandSection: section, expanded: true)
    }
    
    func expandableTableView(tableView: UITableView, heightForRowInSection section: Int) -> CGFloat {
        return 46.0
    }
    
    func numberOfSectionsInExpandableTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func expandableTableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peopleArray.count
    }
    
    func expandableTableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("PeopleSectionCell", forIndexPath: indexPath) as? PeopleSectionCell {
            cell.prepareForReuse()
            cell.configureCell(peopleArray[indexPath.row])
            return cell
        } else {
            return PeopleSectionCell()
        }
    }
    
    func expandableTableView(tableView: UITableView, titleCellForSection section: Int, expanded: Bool) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("SectionTitleCell") as? SectionTitleCell {
            cell.prepareForReuse()
            cell.configureCell("People", tag: 1)
            return cell
        } else {
            return SectionTitleCell()
        }
    }
    
    func expandableTableView(tableView: UITableView, isExpandableSection section: Int) -> Bool {
        return expandableSectionIndices.contains(section)
    }
    
    // MARK: - NAExpandableTableViewDelegate
    
    func expandableTableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    func expandableTableView(tableView: UITableView, didSelectTitleCellInSection section: Int) {
        //        if let titleCell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: section)) as? SectionTitleCell {
        //            titleCell.rotateArrow()
        //        }
    }
    
    func expandableTableView(tableView: UITableView, didExpandSection section: Int, expanded: Bool) {
    }
    

}
