//
//  wearingTodayVC.swift
//  TinyCloset
//
//  Created by Ellen Shin on 7/21/16.
//  Copyright © 2016 Ellen Shin. All rights reserved.
//

import UIKit
import NAExpandableTableController
import CoreData
import DLRadioButton
import SCLAlertView

class wearingTodayVC: UIViewController, NAExpandableTableViewDataSource, NAExpandableTableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var outfitImg: UIImageView!
    
    var numberOfSections: Int!
    let expandableSectionIndices = [0, 1, 2]
    var sectionTitles: [String]!
    var eventArray = [Event]()
    var peopleArray = [Person]()
    var typeArray = [Type]()
    var wearingItToday = false
    var selectedSeason: Seasons = .AllYear
    var favorite = false
    var newOutfit: Outfit?
    
    /// Need to hold strong reference to our expandable table controller
    private var expandableTableController: NAExpandableTableController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if wearingItToday {
            numberOfSections = 3
        } else {
            numberOfSections = 2
        }
        if wearingItToday {
            sectionTitles = ["Event", "People", "Type of clothing"]
        } else {
            sectionTitles = ["Event", "Type of clothing"]
        }
        // First create our NAExpandableTableController instance
        self.expandableTableController = NAExpandableTableController(dataSource: self, delegate: self)
        self.expandableTableController.exclusiveExpand = false
        
        // Now assign it to our tableView's dataSource & delegate, that's it!
        tableView.dataSource = self.expandableTableController
        tableView.delegate = self.expandableTableController
        
        tableView.tableFooterView = UIView(frame: CGRectZero)
        preExpand(0)
        preExpand(1)
        if wearingItToday {
            preExpand(2)
        }
        tableView.reloadData()
        outfitImg.image = DataService.instance.newOutfitImage
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(wearingTodayVC.onContentAdded), name: "contentAdded", object: nil)
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(wearingTodayVC.deleteCell(_:)), name: "cellDeleted", object: nil)
        

    }
    
//    func deleteCell(notification: NSNotification) {
//        let btn = notification.object as! UIButton
//        let stringArr = btn.titleLabel!.text!.characters.split{$0 == " "}.map(String.init)
//        let section = Int(stringArr[0])!
//        let row = Int(stringArr[1])!
//        if wearingItToday {
//            if section == 0 {
//                
//                eventArray.removeAtIndex(row)
//            } else if section == 1 {
//                peopleArray.removeAtIndex(row)
//            } else {
//                typeArray.removeAtIndex(row)
//            }
//        } else {
//            if section == 0 {
//                eventArray.removeAtIndex(row)
//            } else {
//                typeArray.removeAtIndex(row)
//            }
//            
//        }
//        
//        tableView.reloadData()
//    }
    
    func onContentAdded(notification: NSNotification) {
        if wearingItToday {
            if let content = notification.object as? Event {
                eventArray.append(content)
                if expandableTableController.expandDict[0] == false {
                    preExpand(0)
                }
                
            } else if let content = notification.object as? Person {
                peopleArray.append(content)
                if expandableTableController.expandDict[1] == false {
                    preExpand(1)
                }
            } else {
                if let content = notification.object as? Type {
                    typeArray.append(content)
                    if expandableTableController.expandDict[2] == false {
                        preExpand(2)
                    }
                }
            }

        } else {
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

        }
        tableView.reloadData()
    }
    
    @IBAction func minusBtnPressed(sender: AnyObject) {
        let stringArr = sender.titleLabel!!.text!.characters.split{$0 == " "}.map(String.init)
        let section = Int(stringArr[0])!
        let row = Int(stringArr[1])!
        print("\(section), \(row)")
        if wearingItToday {
            if section == 0 {
                print("\(eventArray[row].name!)")
                eventArray.removeAtIndex(row)
                if expandableTableController.expandDict[0] == false {
                    preExpand(0)
                }
            } else if section == 1 {
                peopleArray.removeAtIndex(row)
                if expandableTableController.expandDict[1] == false {
                    preExpand(1)
                }
            } else {
                typeArray.removeAtIndex(row)
                if expandableTableController.expandDict[2] == false {
                    preExpand(2)
                }
                
            }
        } else {
            if section == 0 {
                eventArray.removeAtIndex(row)
                if expandableTableController.expandDict[0] == false {
                    preExpand(0)
                }
            } else {
                typeArray.removeAtIndex(row)
                if expandableTableController.expandDict[1] == false {
                    preExpand(1)
                }
            }

        }
        
        tableView.reloadData()
        
        //let index = NSIndexPath(forRow: row, inSection: section)
        
//        tableView.beginUpdates()
//        tableView.deleteRowsAtIndexPaths([index], withRowAnimation: .Fade)
//        tableView.endUpdates()
    }
//    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        if (editingStyle == UITableViewCellEditingStyle.Delete) {
//            if wearingItToday {
//                if indexPath.section == 0 {
//                    print("\(eventArray[indexPath.row].name!)")
//                    eventArray.removeAtIndex(indexPath.row)
//                    if expandableTableController.expandDict[0] == false {
//                        preExpand(0)
//                    }
//                } else if indexPath.section == 1 {
//                    peopleArray.removeAtIndex(indexPath.row)
//                    if expandableTableController.expandDict[1] == false {
//                        preExpand(1)
//                    }
//                } else {
//                    typeArray.removeAtIndex(indexPath.row)
//                    if expandableTableController.expandDict[2] == false {
//                        preExpand(2)
//                    }
//                    
//                }
//            } else {
//                if indexPath.section == 0 {
//                    eventArray.removeAtIndex(indexPath.row)
//                    if expandableTableController.expandDict[0] == false {
//                        preExpand(0)
//                    }
//                } else {
//                    typeArray.removeAtIndex(indexPath.row)
//                    if expandableTableController.expandDict[1] == false {
//                        preExpand(1)
//                    }
//                }
//                
//            }
//            
//            tableView.reloadData()
//
//        }
//    }
    
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
        if wearingItToday {
            if section == 0 {
                print("\(eventArray.count)")
                return eventArray.count
            } else if section == 1 {
                return peopleArray.count
            } else {
                return typeArray.count
            }
        } else {
            if section == 0 {
                return eventArray.count
            } else {
                return typeArray.count
            }
        }
        
    }
    
    func expandableTableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("SectionCell", forIndexPath: indexPath) as? SectionCell {
            cell.prepareForReuse()
            if wearingItToday {
                let section = indexPath.section
                if section == 0 {
                    cell.configureCell(eventArray[indexPath.row].name!, tag: "\(section) \(indexPath.row)")
                    return cell
                } else if section == 1 {
                    cell.configureCell(peopleArray[indexPath.row].name!, tag: "\(section) \(indexPath.row)")
                    
                    return cell
                } else {
                    cell.configureCell(typeArray[indexPath.row].name!, tag: "\(section) \(indexPath.row)")
                    
                    return cell
                }
            } else {
                let section = indexPath.section
                if section == 0 {
                    cell.configureCell(eventArray[indexPath.row].name!, tag: "\(section) \(indexPath.row)")
                    
                    return cell
                } else {
                    cell.configureCell(typeArray[indexPath.row].name!, tag: "\(section) \(indexPath.row)")
                    
                    return cell
                }
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
    
    @IBAction func addBtnPressed(sender: UIButton) {
        print("\(sender.tag)")
        performSegueWithIdentifier("SearchVC", sender: sender.tag)
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
    
    func generateNewOutfit() {
        let outfit = NSEntityDescription.insertNewObjectForEntityForName("Outfit", inManagedObjectContext: ad.managedObjectContext) as! Outfit
        for event in eventArray {
            outfit.addObject(event, forKey: "events")
        }
        
        if wearingItToday {
            for person in peopleArray {
                outfit.addObject(person, forKey: "persons")
            }
        }
        
        for type in typeArray {
            outfit.addObject(type, forKey: "types")
        }
        outfit.setOutfitImage(outfitImg.image!.correctlyOrientedImage())
        outfit.setSeasonType(selectedSeason)
        outfit.favorite = self.favorite
        if wearingItToday {
            outfit.wearToday(peopleArray)
        }
        
    }
    
    @IBAction func saveBtnPressed(sender: AnyObject) {
        generateNewOutfit()
        let alert = SCLAlertView()
        alert.addButton("Done") {
            self.navigationController?.popToRootViewControllerAnimated(true)
        }
        
        
        alert.showSuccess("Success!", subTitle: "Your new outfit was successfully saved to your closet")
        NSNotificationCenter.defaultCenter().postNotificationName("newOutfitAdded", object: nil)
        
    }
    
    @IBAction func backBtnPressed(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
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