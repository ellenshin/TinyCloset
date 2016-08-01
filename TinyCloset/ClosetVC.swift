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
    
    var outfits = [Outfit]()
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        //let menuView = CustomDropdownMenu(navigationController: self.navigationController, title: items.first!, items: items)
        let menuView = CustomDropdownMenu(navigationController: self.navigationController, containerView: self.navigationController!.view, title: items.first!, items: items)
        self.navigationItem.titleView = menuView
        
        refresh()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ClosetVC.refresh), name: "newOutfitAdded", object: nil)
        
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return outfits.count
    }
    
    func refresh() {
        fetchAndSetResult()
        collectionView.reloadData()
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("OutfitCell", forIndexPath: indexPath) as? OutfitCell {
            
            let outfit = outfits[indexPath.row]
            cell.configureCell(outfit)
            return cell
            
        } else {
            return OutfitCell()
        }
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
//    func controllerWillChangeContent(controller: NSFetchedResultsController) {
//        collectionView.beginUpdates()
//    }
//    
//    
//    func controllerDidChangeContent(controller: NSFetchedResultsController) {
//        collectionView.endUpdates()
//    }
    
    
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
        performSegueWithIdentifier("OutfitDetailsVC", sender: outfits[indexPath.row])
    }
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
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}