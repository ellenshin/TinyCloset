//
//  ViewMoreOutfitsVC.swift
//  TinyCloset
//
//  Created by Ellen Shin on 8/15/16.
//  Copyright © 2016 Ellen Shin. All rights reserved.
//

import UIKit

class ViewMoreOutfitsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var pairList = [Pair]()
    var date: NSDate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dateFormatter.dateFormat = "EEEE, MMM dd"
        dateLbl.text = dateFormatter.stringFromDate(date)
        
        tableView.delegate = self
        tableView.dataSource = self
    }

    @IBAction func backBtnPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func addBtnPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
        NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "addedOutfit", object: nil))
    }
    
    @IBAction func replaceBtnPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
        NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "replacedOutfit", object: pairList[sender.tag]))
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pairList.count
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
    
}
