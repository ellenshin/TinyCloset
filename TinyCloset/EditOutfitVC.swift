//
//  EditOutfitVC.swift
//  TinyCloset
//
//  Created by Ellen Shin on 8/11/16.
//  Copyright © 2016 Ellen Shin. All rights reserved.
//

import UIKit
import DLRadioButton
import NAExpandableTableController
import SCLAlertView
import CoreData

class EditOutfitVC: UIViewController, NAExpandableTableViewDataSource, NAExpandableTableViewDelegate {

    @IBOutlet weak var springBtn: DLRadioButton!
    @IBOutlet weak var fallBtn: DLRadioButton!
    @IBOutlet weak var allYearBtn: DLRadioButton!
    @IBOutlet weak var summerBtn: DLRadioButton!
    @IBOutlet weak var winterBtn: DLRadioButton!
    @IBOutlet weak var yesFavoriteBtn: DLRadioButton!
    @IBOutlet weak var notReallyFavoriteBtn: DLRadioButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var outfitImg: CustomImageView!
    
    var outfit: Outfit!
    var eventArray = [Event]()
    var typeArray = [Type]()
    var numberOfSections = 2
    let expandableSectionIndices = [0, 1]
    var sectionTitles = ["Event", "Type of clothing"]
    var selectedSeason: Seasons = .AllYear
    var favorite = false
    
    private var expandableTableController: NAExpandableTableController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.expandableTableController = NAExpandableTableController(dataSource: self, delegate: self)
        self.expandableTableController.exclusiveExpand = false
        tableView.dataSource = self.expandableTableController
        tableView.delegate = self.expandableTableController
        
        tableView.tableFooterView = UIView(frame: CGRectZero)
        preExpand(0)
        preExpand(1)
        configure()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(wearingTodayVC.onContentAdded), name: "contentAdded", object: nil)
    }
    func configure() {
        
        outfitImg.image = UIImage(data: outfit.image!)
        
        if outfit.season == "All year" {
            allYearBtn.selected = true
        } else if outfit.season == "Winter" {
            winterBtn.selected = true
        } else if outfit.season == "Summer" {
            summerBtn.selected = true
        } else if outfit.season == "Spring" {
            springBtn.selected = true
        } else {
            fallBtn.selected = true
        }
        
        if outfit.favorite == true {
            yesFavoriteBtn.selected = true
        } else {
            notReallyFavoriteBtn.selected = true
        }
        
        eventArray = outfit.events?.allObjects as! [Event]
        typeArray = outfit.types?.allObjects as! [Type]
        
        tableView.reloadData()
        
    }
    func onContentAdded(notification: NSNotification) {
            if let content = notification.object as? Event {
                eventArray.append(content)
                if expandableTableController.expandDict[0] == false {
                    preExpand(0)
                }
                
            } else {
                if let content = notification.object as? Type {
                    typeArray.append(content)
                    if expandableTableController.expandDict[1] == false {
                        preExpand(1)
                    }
                }
            
        }
        tableView.reloadData()
    }
    
    func preExpand(section: Int) {
        expandableTableController.expandDict[section] = true
        tableView.beginUpdates()
        
        var indexPaths = [NSIndexPath]()
        if let rows = expandableTableController.dataSource?.expandableTableView(tableView, numberOfRowsInSection: section) {
            if rows > 0 {
                for rowIndex in 1...rows {
                    indexPaths.append(NSIndexPath(forRow: rowIndex, inSection: section))
                }
            }
        }
        
        tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .None)
        tableView.endUpdates()
        
        expandableTableController.delegate?.expandableTableView?(tableView, didExpandSection: section, expanded: true)
    }

    func expandableTableView(tableView: UITableView, heightForRowInSection section: Int) -> CGFloat {
        return 25.0
    }
    
    func numberOfSectionsInExpandableTableView(tableView: UITableView) -> Int {
        return numberOfSections
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool
    {
        return true
    }

    func expandableTableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if section == 0 {
                return eventArray.count
            } else {
                return typeArray.count
            }
    }
    
    func expandableTableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("SectionCell", forIndexPath: indexPath) as? SectionCell {
            cell.prepareForReuse()

                let section = indexPath.section
                if section == 0 {
                    cell.configureCell(eventArray[indexPath.row].name!, tag: "\(section) \(indexPath.row)")
                    
                    return cell
                } else {
                    cell.configureCell(typeArray[indexPath.row].name!, tag: "\(section) \(indexPath.row)")
                    
                    return cell
                }
            
        } else {
            return SectionCell()
        }
    }
    
    func expandableTableView(tableView: UITableView, titleCellForSection section: Int, expanded: Bool) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("SectionTitleCell") as? SectionTitleCell {
            cell.prepareForReuse()
            cell.configureCell("\(sectionTitles[section])", tag: section)
            return cell
        } else {
            return SectionTitleCell()
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SearchVC" {
            if let searchVC = segue.destinationViewController as? SearchVC {
                if let tag = sender as? Int {
                    print("\(tag)")
                    searchVC.contentKind = sectionTitles[tag]
                }
            }
        }
    }
    
    func EditOutfit() {
        let context = ad.managedObjectContext
        let predicate = NSPredicate(format: "self == %@", outfit.objectID)
        
        let fetchRequest = NSFetchRequest(entityName: "Outfit")
        fetchRequest.predicate = predicate
        
        do {
            let fetchedEntities = try context.executeFetchRequest(fetchRequest) as! [Outfit]
            let outfitToBeEdited = fetchedEntities.first!
            outfitToBeEdited.events = NSSet(array: eventArray)
            outfitToBeEdited.types = NSSet(array: typeArray)
            outfitToBeEdited.setSeasonType(selectedSeason)
            outfitToBeEdited.favorite = self.favorite
            
        } catch {
            // Do something in response to error condition
        }
        
        do {
            try context.save()
        } catch {
            // Do something in response to error condition
        }
        
    }

    
    @IBAction func springBtnSelected(sender: DLRadioButton) {
        selectedSeason = .Spring
    }
    
    @IBAction func summerBtnSelected(sender: DLRadioButton) {
        selectedSeason = .Summer
    }
    
    @IBAction func fallBtnSelected(sender: DLRadioButton) {
        selectedSeason = .Fall
    }
    
    @IBAction func winterBtnSelected(sender: DLRadioButton) {
        selectedSeason = .Winter
    }
    
    @IBAction func allYearBtnSelected(sender: DLRadioButton) {
        selectedSeason = .AllYear
    }
    
    @IBAction func favoriteSelected(sender: DLRadioButton) {
        favorite = true
    }
    
    @IBAction func unfavoriteSelected(sender: DLRadioButton) {
        favorite = false
    }

    
    @IBAction func addBtnPressed(sender: UIButton) {
        print("\(sender.tag)")
        performSegueWithIdentifier("SearchVC", sender: sender.tag)
    }

    @IBAction func cancelBtnPressed(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func saveBtnPressed(sender: AnyObject) {
        EditOutfit()
        let alert = SCLAlertView()
        alert.addButton("Done") {
            self.navigationController?.popToRootViewControllerAnimated(true)
        }
        
        
        alert.showSuccess("Success!", subTitle: "Your outfit was successfully edited")
        NSNotificationCenter.defaultCenter().postNotificationName("outfitEdited", object: outfit)
    }

    @IBAction func imgPressed(sender: AnyObject) {
        
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
