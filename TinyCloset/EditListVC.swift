//
//  EditListVC.swift
//  TinyCloset
//
//  Created by Ellen Shin on 8/9/16.
//  Copyright © 2016 Ellen Shin. All rights reserved.
//

import UIKit
import SCLAlertView
import CoreData

class EditListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var outfitImg: CustomImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var outfit: Outfit!
    var pairList = [Pair]()
    var date: NSDate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dateFormatter.dateFormat = "EEEE, MMM dd"
        dateLbl.text = dateFormatter.stringFromDate(date)
        
        getPairList()
        outfitImg.image = UIImage(data: outfit.image!)
        tableView.dataSource = self
        tableView.delegate = self
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pairList.count
    }
    
    func getPairList() {
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
        
        let dateEntity = results[0]
        
        pairList = dateEntity.pairs!.allObjects as! [Pair]
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("OutfitListCell") as? OutfitListCell {
            let pair = pairList[indexPath.row]
            cell.configureCell(pair, tag: indexPath.row)
            return cell
            
        } else {
            return OutfitListCell()
        }
    }
    @IBAction func replaceBtnPressed(sender: UIButton) {
        let alert = SCLAlertView()
        alert.addButton("Done") {
            self.dismissViewControllerAnimated(true, completion: nil)
            NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "replacedOutfit", object: self.pairList[sender.tag]))
        }
        
        
        alert.showSuccess("Success!", subTitle: "Your new outfit was successfully replaced")
        
    }
    
    @IBAction func cancelBtnPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func addBtnPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
        NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "addedOutfit", object: nil))
    }
}
