//
//  ClosetVC.swift
//  TinyCloset
//
//  Created by Ellen Shin on 7/12/16.
//  Copyright © 2016 Ellen Shin. All rights reserved.
//

import UIKit
import BTNavigationDropdownMenu
import CoreData

class ClosetVC: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    let items = ["Most Recent", "Least Recent", "Most Frequent", "Least Frequent", "Favorites"]
    var fetchedResultsController: NSFetchedResultsController!
    
    var outfits = [Outfit]()
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        let menuView = CustomDropdownMenu(navigationController: self.navigationController, title: items.first!, items: items)
        self.navigationItem.titleView = menuView
        
        //generateTestData()
        refresh()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ClosetVC.refresh), name: "newOutfitAdded", object: nil)
        
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return outfits.count
    }
    
    func refresh() {
        fetchAndSetResult()
        tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCellWithIdentifier("OutfitCell") as? OutfitCell {
            
            let outfit = outfits[indexPath.row]
            cell.configureCell(outfit)
            return cell
            
        } else {
            return OutfitCell()
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }
    
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }
    
    
//    func attemptFetch() {
//        setFetchedResults()
//        
//        do {
//            try self.fetchedResultsController.performFetch()
//        } catch {
//            let error = error as NSError
//            print("\(error), \(error.userInfo)")
//        }
//    }
    
    func fetchAndSetResult() {
        
        let context = ad.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Outfit")
        
        do {
            let results = try context.executeFetchRequest(fetchRequest)
            outfits = results as! [Outfit]
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
//    func generateTestData() {
//        let person1 = NSEntityDescription.insertNewObjectForEntityForName("Person", inManagedObjectContext: ad.managedObjectContext) as! Person
//        person1.name = "Isabella"
//        
//        let person2 = NSEntityDescription.insertNewObjectForEntityForName("Person", inManagedObjectContext: ad.managedObjectContext) as! Person
//        person2.name = "Jeremy"
//        
//        let outfit1 = NSEntityDescription.insertNewObjectForEntityForName("Outfit", inManagedObjectContext: ad.managedObjectContext) as! Outfit
//        
//        outfit1.setOutfitImage(UIImage(named: "outfit")!)
//        outfit1.wearToday()
//        outfit1.addObject(person1, forKey: "persons")
//        outfit1.addObject(person2, forKey: "persons")
//        person1.addObject(outfit1, forKey: "outfits")
//        person2.addObject(outfit1, forKey: "outfits")
//        outfit1.occasion = "Hanging out with"
//        
//        let person3 = NSEntityDescription.insertNewObjectForEntityForName("Person", inManagedObjectContext: ad.managedObjectContext) as! Person
//        person3.name = "Anderson"
//        
//        let outfit2 = NSEntityDescription.insertNewObjectForEntityForName("Outfit", inManagedObjectContext: ad.managedObjectContext) as! Outfit
//        
//        outfit2.setOutfitImage(UIImage(named: "outfit2")!)
//        outfit2.wearToday()
//        outfit2.addObject(person3, forKey: "persons")
//        outfit2.addObject(person2, forKey: "persons")
//        person3.addObject(outfit2, forKey: "outfits")
//        person2.addObject(outfit2, forKey: "outfits")
//        outfit2.occasion = "Partying with"
//        
//        let outfit3 = NSEntityDescription.insertNewObjectForEntityForName("Outfit", inManagedObjectContext: ad.managedObjectContext) as! Outfit
//        
//        outfit3.setOutfitImage(UIImage(named: "outfit3")!)
//        outfit3.wearToday()
//        outfit3.addObject(person3, forKey: "persons")
//        outfit3.addObject(person2, forKey: "persons")
//        outfit3.addObject(person1, forKey: "persons")
//        
//        person3.addObject(outfit3, forKey: "outfits")
//        person2.addObject(outfit3, forKey: "outfits")
//        person1.addObject(outfit3, forKey: "outfits")
//        outfit3.occasion = "Going camping with"
//
//        
//    }
    
//    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
//        
//        switch(type) {
//        case .Insert:
//            if let indexPath = newIndexPath {
//                tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
//            }
//            break
//        case .Delete:
//            if let indexPath = indexPath {
//                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
//            }
//            break
//        case .Update:
//            if let indexPath = indexPath {
//                let cell = tableView.cellForRowAtIndexPath(indexPath) as! OutfitCell
//                configureCell(cell, indexPath: indexPath)
//            }
//            break
//        case .Move:
//            if let indexPath = indexPath {
//                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
//            }
//            
//            if let newIndexPath = newIndexPath {
//                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Fade)
//            }
//            break
//        }
//    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}