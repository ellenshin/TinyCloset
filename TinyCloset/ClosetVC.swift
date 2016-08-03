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

class ClosetVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    let items = ["Most Recent", "Least Recent", "Most Frequent", "Least Frequent", "Favorites"]
    var fetchedResultsController: NSFetchedResultsController!
    
    //var outfits = [Outfit]()
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        //let menuView = CustomDropdownMenu(navigationController: self.navigationController, title: items.first!, items: items)
        let menuView = CustomDropdownMenu(navigationController: self.navigationController, containerView: self.navigationController!.view, title: items.first!, items: items)
        self.navigationItem.titleView = menuView
        attemptFetch()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ClosetVC.attemptFetch), name: "newOutfitAdded", object: nil)
        
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let sections = fetchedResultsController.sections {
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        } else {
            return 0
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("OutfitCell", forIndexPath: indexPath) as! OutfitCell
        configureCell(cell, indexPath: indexPath)
        return cell
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "OutfitDetailsVC" {
            if let VC = segue.destinationViewController as? OutfitDetailsVC {
                if let outfit = sender as? Outfit {
                    VC.outfit = outfit
                }
            }
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if let objs = fetchedResultsController.fetchedObjects where objs.count > 0 {
            if let outfit = objs[indexPath.row] as? Outfit {
                performSegueWithIdentifier("OutfitDetailsVC", sender: outfit)
            } else {
                print("not able to load")
            }
        }
    }
    
//    func fetchAndSetResult() {
//        
//        let context = ad.managedObjectContext
//        let fetchRequest = NSFetchRequest(entityName: "Outfit")
//        
//        do {
//            let results = try context.executeFetchRequest(fetchRequest)
//            outfits = results as! [Outfit]
//        } catch let err as NSError {
//            print(err.debugDescription)
//        }
//    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        
        switch(type) {
        case .Insert:
            if let indexPath = newIndexPath {
                collectionView.insertItemsAtIndexPaths([indexPath])
                collectionView.reloadData()
            }
            break
        case .Delete:
            if let indexPath = indexPath {
                collectionView.deleteItemsAtIndexPaths([indexPath])
                collectionView.reloadData()
            }
            break
        case .Update:
            if let indexPath = indexPath {
                let cell = collectionView.cellForItemAtIndexPath(indexPath) as! OutfitCell
                configureCell(cell, indexPath: indexPath)
                collectionView.reloadData()
            }
            break
        case .Move:
            if let indexPath = indexPath {
                collectionView.deleteItemsAtIndexPaths([indexPath])
            }
            
            if let newIndexPath = newIndexPath {
                collectionView.insertItemsAtIndexPaths([newIndexPath])
            }
            collectionView.reloadData()
            break
        }
    }

    
    func configureCell(cell: OutfitCell, indexPath: NSIndexPath) {
        if let outfit = fetchedResultsController.objectAtIndexPath(indexPath) as? Outfit {
            cell.configureCell(outfit)
        }
    }
    
    func attemptFetch() {
        setFetchedResults()
        
        do {
            try self.fetchedResultsController.performFetch()
        } catch {
            let error = error as NSError
            print("\(error), \(error.userInfo)")
        }
        collectionView.reloadData()
    }
    
    func setFetchedResults() {
//        let section: String? = segment.selectedSegmentIndex == 1 ? "store.name" : nil
        
        let fetchRequest = NSFetchRequest(entityName: "Outfit")
        
        let sortDescriptor = NSSortDescriptor(key: "lastWorn", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: ad.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
        controller.delegate = self
        
        fetchedResultsController = controller
    }

    
    
    
    
    
    
    
}